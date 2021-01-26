import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {

  UserAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountFragment(key: super.key);
  }
}

class UserAccountFragment extends StatefulWidget {

  UserAccountFragment({Key key}) : super(key: key);

  @override
  _UserAccountFragmentState createState() => _UserAccountFragmentState();
}

class _UserAccountFragmentState extends State<UserAccountFragment> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "حساب کاربری",
        style:
            TextStyle(color: Colors.blueAccent, fontSize: 14, fontFamily: "yekan"),
      ),
    );
  }
}