import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast/ToastUtils.dart';

class CallsAndMessagesService {
  void call(BuildContext context, String number) async {
    String url = "tel:$number";

    if (await canLaunch(url)) {
      launch(url);
    } else {
      ToastUtils.showCustomToast(
          context,
          Icon(Icons.error, color: Colors.white),
          Colors.redAccent,
          "نرم افزاری برای تماس یافت نشد");
    }
  }

  void sendSms(BuildContext context, String number, String message) async {
    String url = "sms:$number?body=$message";

    if (Platform.isIOS) {
      url = 'sms:$number&body=$message';
    }

    if (await canLaunch(url)) {
      launch(url);
    } else {
      ToastUtils.showCustomToast(
          context,
          Icon(Icons.error, color: Colors.white),
          Colors.redAccent,
          "نرم افزاری برای ارسال پیام یافت نشد");
    }
  }

  void sendEmail(BuildContext context, String email) async {
    String url = "mailto:$email";

    if (await canLaunch(url)) {
      launch(url);
    } else {
      ToastUtils.showCustomToast(
          context,
          Icon(Icons.error, color: Colors.white),
          Colors.redAccent,
          "نرم افزاری برای ارسال ایمیل یافت نشد");
    }
  }
}
