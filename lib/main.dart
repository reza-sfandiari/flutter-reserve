import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'pages/Home.dart';
import 'pages/Search.dart';
import 'pages/Setting.dart';
import 'pages/UserAccount.dart';
import 'utils/CallsAndMessagesService.dart';
import 'utils/toast/ToastUtils.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

void setupLocator() {
  GetIt.instance.registerSingleton(CallsAndMessagesService());
}

class MyApp extends StatelessWidget {

  GetIt get getIt => GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _onBack = false;

  var currentIndex = 0;
  String title = "اسکانجار";

  var items = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/images/home.svg",
            color: Colors.grey, width: 20, height: 20),
        activeIcon: SvgPicture.asset("assets/images/home.svg",
            color: Colors.blueAccent, width: 20, height: 20),
        title: Text('اسکانجار')),
    BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/images/search.svg",
            color: Colors.grey, width: 20, height: 20),
        activeIcon: SvgPicture.asset("assets/images/search.svg",
            color: Colors.blueAccent, width: 20, height: 20),
        title: Text('جستجو')),
    BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/images/user.svg",
            color: Colors.grey, width: 20, height: 20),
        activeIcon: SvgPicture.asset("assets/images/user.svg",
            color: Colors.blueAccent, width: 20, height: 20),
        title: Text('حساب کاربری')),
    BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('تنظیمات'))
  ];

  List<Widget> pageList = List<Widget>();

  @override
  void initState() {
    pageList.add(Home(key: Key('Home')));
    pageList.add(Search(key: Key('Search')));
    pageList.add(UserAccount(key: Key('UserAccount')));
    pageList.add(Setting(key: Key('Setting')));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WillPopScope(
          child: Scaffold(
              appBar: AppBar(
                  title: Text(title,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'yekan')),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
                  ],
                  elevation: 8.0,
                  leading: IconButton(
                    icon: SvgPicture.asset("assets/images/filter.svg",
                        color: Colors.white, width: 20, height: 20),
                    onPressed: () => {},
                  )),
              body: IndexedStack(
                index: currentIndex,
                children: pageList,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blueAccent,
                selectedIconTheme: IconThemeData(size: 16.0),
                unselectedIconTheme: IconThemeData(size: 14.0),
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.blueAccent,
                    fontFamily: 'yekan',
                    fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontFamily: 'yekan',
                    fontWeight: FontWeight.normal),
                onTap: (index) {
                  click(index);
                },
                elevation: 8.0,
                items: items,
              ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
          onWillPop: () => _exitToast(),
        ),
      ],
    );
  }

  void click(int index) {
    setState(() {
      currentIndex = index;
      title = (items[index].title as Text).data;
    });
  }

  Future<bool> _exitToast() async {
    if (_onBack) {
      SystemNavigator.pop();
      return true;
    }

    _onBack = true;

    ToastUtils.showCustomToast(
        context,
        Icon(Icons.power_settings_new, color: Colors.white),
        Colors.blueAccent,
        "برای خروج مجددا بازگشت را بزنید");

    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _onBack = false;
      });
    });

    return true;
  }
}
