import 'package:flutter/material.dart';

class Setting extends StatelessWidget {

  Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingFragment(key: super.key);
  }
}

class SettingFragment extends StatefulWidget {

  SettingFragment({Key key}) : super(key: key);

  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "تنظیمات",
        style:
            TextStyle(color: Colors.blueAccent, fontSize: 14, fontFamily: "yekan"),
      ),
    );
  }
}