import 'package:flutter/material.dart';

class ListEmk extends StatefulWidget {
  final String title;
  final List<String> list;

  ListEmk(this.title, this.list);

  @override
  _ListEmkState createState() => _ListEmkState();
}

class _ListEmkState extends State<ListEmk> {
  @override
  Widget build(BuildContext context) {
    return widget.list.length > 0
        ? Container(
            child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(widget.title,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: "yekan",
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(height: 16),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      scrollDirection: Axis.vertical,
                      children: List.generate(widget.list.length, (index) {
                        return GridTile(
                          child: Row(

                            children: <Widget>[
                              Icon(Icons.check_circle,color: Colors.green,size: 18),

                              SizedBox(width: 4),

                              Text(widget.list[index],

                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: "yekan",
                                      fontSize: 12.0,
                                      color: Colors.black87))

                            ],

                          ),
                        );
                      }),
                    )),
              ],
            ),
          )
        : Container();
  }
}
