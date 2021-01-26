import 'dart:collection';

import 'package:Reserve/model/VillaModel.dart';
import 'package:Reserve/utils/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Villa.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeFragment();
  }
}

class HomeFragment extends StatefulWidget {
  HomeFragment({Key key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  ScrollController controller = ScrollController();

  var isLoadMore = false;
  var isRefresh = false;
  var firstTime = true;
  var firstLoading = true;

  var _page = 1;

  List villaList = List<VillaModel>();

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      firstTime = false;
      _loadVilla(_page);
    }

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Stack(
        children: <Widget>[
          Center(
            child: firstLoading == true ? CircularProgressIndicator() : null,
          ),
          ListView.builder(
            controller: controller,
            itemCount: villaList.length,
            itemBuilder: (context, index) {
              VillaModel villaModel = villaList[index];

              if (villaModel.isLoad) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                    onTap: () {
                      _listItemTap(villaModel);
                    },
                    child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(children: <Widget>[
                          Row(textDirection: TextDirection.rtl, children: <
                              Widget>[
                            Expanded(
                              flex: 1,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                textDirection: TextDirection.rtl,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    child: Image.network(
                                        "BASE_URL" +
                                            villaModel.image_slider[0],
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.all(4),
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white24),
                                        child: Align(
                                          widthFactor: 1.2,
                                          child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              spacing: 4,
                                              textDirection: TextDirection.rtl,
                                              children: <Widget>[
                                                Icon(Icons.remove_red_eye,
                                                    size: 12,
                                                    color: Colors.white),
                                                Text(
                                                    Utility.convertNumberPr(
                                                        villaList[index]
                                                            .totalvisit),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontFamily: 'yekan')),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Stack(children: <Widget>[
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          textDirection: TextDirection.rtl,
                                          children: <Widget>[
                                            Text(villaModel.villa_subject,
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'yekan')),
                                            Text(
                                                "کرایه هر شب " +
                                                    Utility.convertMoney(
                                                        villaModel.money) +
                                                    " تومان",
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'yekan')),
                                            Text(
                                                villaModel.province +
                                                    " - " +
                                                    villaModel.city +
                                                    " - " +
                                                    villaModel.address,
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'yekan')),
                                            SizedBox(height: 8),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      SvgPicture.asset(
                                                          "assets/images/room.svg",
                                                          color: Colors.black54,
                                                          height: 16,
                                                          width: 16),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          villaModel.rooms +
                                                              " اتاق",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  'yekan')),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      SvgPicture.asset(
                                                          "assets/images/floor.svg",
                                                          color: Colors.black54,
                                                          height: 16,
                                                          width: 16),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          villaModel.floors +
                                                              " طبقه",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  'yekan')),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      SvgPicture.asset(
                                                          "assets/images/guest.svg",
                                                          color: Colors.black54,
                                                          height: 16,
                                                          width: 16),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          villaModel.max_Guest +
                                                              " نفر",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  'yekan')),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      SvgPicture.asset(
                                                          "assets/images/area.svg",
                                                          color: Colors.black54,
                                                          height: 16,
                                                          width: 16),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          villaModel.estate_area
                                                                  .toString() +
                                                              " متر",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  'yekan')),
                                                    ],
                                                  )
                                                ])
                                          ])
                                    ])))
                          ])
                        ])));
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    controller.addListener(() {
      _scrollListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(() {
      _scrollListener();
    });
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.extentAfter < 200) {
      if (!isRefresh) {
        isRefresh = true;
        isLoadMore = true;
        _page++;
        _loadVilla(_page).then((list) {
          setState(() {
            if (list != null && list <= 0) {
              _page--;
            }
          });
        });
      }
    }
  }

  _loadVilla(var page) async {
    Iterable list = await _getVilla(page);

    if (list.length <= 0) {
      page--;
    } else
      setState(() {
        if (this.villaList.length <= 0) {
          this.villaList =
              list.map((_json) => VillaModel.fromJson(_json)).toList();
        } else {
          this.villaList.removeLast();

          this
              .villaList
              .addAll(list.map((_json) => VillaModel.fromJson(_json)).toList());
        }

        this.villaList.add(VillaModel.loadMore());

        firstLoading = false;
        isLoadMore = false;
        isRefresh = false;
      });

    print("_loadVilla of page $page");
  }

  _getVilla(var page) async {
    http.Response response =
        await http.get("BASE_URL/app/api/villa?page=$page");
    if (response.statusCode != 200) return null;
    return json.decode(response.body);
  }

  _listItemTap(VillaModel model) {
    if (!model.isLoad)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Villa(model)));
  }
}
