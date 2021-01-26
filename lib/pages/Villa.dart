import 'package:Reserve/model/VillaModel.dart';
import 'package:Reserve/utils/CallsAndMessagesService.dart';
import 'package:Reserve/utils/Utility.dart';
import 'package:Reserve/wgt/ListEmk.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'GalleryFullScreen.dart';

class Villa extends StatelessWidget {
  final VillaModel model;

  Villa(this.model);

  @override
  Widget build(BuildContext context) {
    return VillaDetails(model);
  }
}

class VillaDetails extends StatefulWidget {
  final VillaModel model;

  VillaDetails(this.model);

  @override
  _VillaDetailsState createState() => _VillaDetailsState();
}

class _VillaDetailsState extends State<VillaDetails> {
  final CallsAndMessagesService _service =
      GetIt.instance<CallsAndMessagesService>();

  CarouselController buttonCarouselController = CarouselController();
  var datePickerCarouselController = TextEditingController();

  VillaModel get model => widget.model;

  PersianDatePickerWidget persianDatePicker;

  String dropdownDayStayValue = 'انتخاب مدت اقامت';
  String dropdownCountPeopleValue = 'انتخاب تعداد نفرات';

  List<String> listDayStay = Utility.getListDaysStay();
  List<String> listCountPeople = Utility.getListCountPeople();

  @override
  Widget build(BuildContext context) {
    persianDatePicker = PersianDatePicker(
        controller: datePickerCarouselController,
        fontFamily: 'yekan',
        outputFormat: 'YYYY/MM/DD',
        daysBorderWidth: 0.5,
        changePageDuration: Duration(milliseconds: 100),
        rangeDatePicker: false,
        farsiDigits: true,
        dayBlockRadius: 0,
        showGregorianDays: false,
        headerTodayBackgroundColor: Colors.white,
        weekCaptionsBackgroundColor: Colors.white,
        weekCaptionsTextStyle: TextStyle(color: Colors.blueAccent),
        headerBackgroundColor: Colors.white,
        headerTodayTextStyle: TextStyle(color: Colors.blueAccent),
        headerTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 14),
        headerTodayIcon: Icon(
          Icons.date_range,
          color: Colors.blueAccent,
          size: 20,
        )).init();

    List<String> listVision = Utility.getVision(model.emkanat);
    List<String> listType = Utility.getVillaType(model.emkanat);
    List<String> listSecurity = Utility.getVillaSecurity(model.emkanat);
    List<String> listWelfareAmenities =
        Utility.getWelfareAmenities(model.emkanat);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("کد ${model.villa_code}",
              style: TextStyle(
                  fontSize: 14, color: Colors.white, fontFamily: 'yekan')),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
              icon: model.liked == 0
                  ? SvgPicture.asset("assets/images/_heart.svg",
                      height: 24, color: Colors.white, width: 24)
                  : SvgPicture.asset("assets/images/heart.svg",
                      height: 24, width: 24),
              onPressed: () {
                setState(() {
                  if (model.liked == 0)
                    model.liked = 1;
                  else
                    model.liked = 0;
                });
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 200,
                autoPlayCurve: Curves.linear,
//                carouselController: buttonCarouselController,
                aspectRatio: 0.2,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
              itemCount: model.image_slider.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryFullScreen(model.image_slider, index)));
                  },
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          "BASE_URL" + model.image_slider[index],
                          fit: BoxFit.cover,
                          width: 1000),
                    ),
                  ),
                );
              },
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () => _openReserveButtonSheet(),
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: <Widget>[
                                Text("رزرو",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "yekan",
                                        fontSize: 12.0)),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              ],
                            )),
                        Text(
                          model.villa_subject,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "yekan",
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      color: Colors.grey,
                      height: 2,
                      width: 60,
                      margin: const EdgeInsets.only(top: 8),
                    ),
                    SizedBox(height: 32),
                    Text('مشخصات مالک',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "yekan",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(model.villa_rname + " " + model.villa_rfamily,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "yekan",
                                    fontSize: 14.0)),
                            SvgPicture.asset("assets/images/user.svg",
                                width: 20, height: 20, color: Colors.grey)
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 4),
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: GestureDetector(
                                      onTap: () {
                                        _service.call(
                                            context, model.villa_rphone);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/phone.svg"),
                                    )),
                                SizedBox(width: 2),
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: GestureDetector(
                                      onTap: () {
                                        _service.sendSms(
                                            context,
                                            model.villa_rphone,
                                            "سلام\nمن میخواستم ویلا با کد ${model.villa_code} را اجاره کنم\nممنون میشم با بنده تماس بگیرید");
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/message.svg"),
                                    )),
                                SizedBox(width: 2),
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: SvgPicture.asset(
                                        "assets/images/telegram.svg")),
                                SizedBox(width: 2),
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SvgPicture.asset(
                                          "assets/images/whatsapp.svg"),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text('قیمت اجاره',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "yekan",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    Text(
                        'اجاره روزانه از ${Utility.convertMoney(model.money)} تومان',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "yekan",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent)),
                    SizedBox(height: 4),
                    Text(
                      model.text1,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "yekan",
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('آدرس ملک',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "yekan",
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                SizedBox(height: 8),
                                Text(
                                  model.province +
                                      " / " +
                                      model.city +
                                      " \n " +
                                      model.address,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "yekan",
                                      fontSize: 12.0),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('مشخصات ملک',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "yekan",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.grey)),
                                SizedBox(height: 8),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              "assets/images/room.svg",
                                              color: Colors.black54,
                                              height: 16,
                                              width: 16),
                                          SizedBox(height: 4),
                                          Text(model.rooms + " اتاق",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54,
                                                  fontFamily: 'yekan')),
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              "assets/images/floor.svg",
                                              color: Colors.black54,
                                              height: 16,
                                              width: 16),
                                          SizedBox(height: 4),
                                          Text(model.floors + " طبقه",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54,
                                                  fontFamily: 'yekan')),
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              "assets/images/guest.svg",
                                              color: Colors.black54,
                                              height: 16,
                                              width: 16),
                                          SizedBox(height: 4),
                                          Text(model.max_Guest + " نفر",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54,
                                                  fontFamily: 'yekan')),
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              "assets/images/area.svg",
                                              color: Colors.black54,
                                              height: 16,
                                              width: 16),
                                          SizedBox(height: 4),
                                          Text(
                                              model.estate_area.toString() +
                                                  " متر",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54,
                                                  fontFamily: 'yekan')),
                                        ],
                                      )
                                    ])
                              ],
                            ))
                      ],
                    ),
                    SizedBox(height: 16),
                    ListEmk("چشم انداز", listVision),
                    SizedBox(height: 32),
                    ListEmk("نوع ملک", listType),
                    SizedBox(height: 32),
                    ListEmk("حریم خصوصی و امنیت", listSecurity),
                    SizedBox(height: 32),
                    ListEmk("امکانات", listWelfareAmenities),
                    Text('نقشه',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "yekan",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    Text(
                        'برای باز کردن نقشه با مسیر یاب لطفا روی تصویر نقشه ضربه بزنید',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "yekan",
                            fontSize: 10.0,
                            color: Colors.redAccent)),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                          Utility.latLangConverter(
                              35.7974686, 51.4330491, 400, 400, 16),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: 16),
                    Text('توضیحات',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "yekan",
                            fontSize: 12.0,
                            color: Colors.grey)),
                    Text(
                      model.text2,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "yekan",
                          fontSize: 12.0),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _openReserveButtonSheet() {
    Dialog reserveDialog = Dialog(
      child: Container(
        child: Wrap(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16), child: persianDatePicker),
            Padding(padding: EdgeInsets.all(16), child: Container()),
            Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: dropdownCountPeopleValue,
                      iconDisabledColor: Colors.blueAccent,
                      iconEnabledColor: Colors.blueAccent,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownCountPeopleValue = newValue;
                        });
                      },
                      items: listCountPeople
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(value,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontFamily: "yekan",
                                    fontSize: 12,
                                    color: Colors.blueAccent)),
                          ),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: dropdownDayStayValue,
                      iconDisabledColor: Colors.blueAccent,
                      iconEnabledColor: Colors.blueAccent,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownDayStayValue = newValue;
                        });
                      },
                      items: listDayStay
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(value,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontFamily: "yekan",
                                    fontSize: 12,
                                    color: Colors.blueAccent)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.blueAccent,
                  child: Text("انصراف",
                      style: TextStyle(
                          fontFamily: "yekan",
                          fontSize: 14,
                          color: Colors.white)),
                ),
                FlatButton(
                  onPressed: () {},
                  color: Colors.blueAccent,
                  child: Text("درخواست رزرو",
                      style: TextStyle(
                          fontFamily: "yekan",
                          fontSize: 14,
                          color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => reserveDialog);
  }
}
