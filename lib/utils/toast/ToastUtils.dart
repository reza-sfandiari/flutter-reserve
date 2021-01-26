import 'dart:async';

import 'package:flutter/material.dart';
import 'ToastMessageAnimation.dart';

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(
      BuildContext context, Icon icon, Color color, String message) {
    if (toastTimer != null) toastTimer.cancel();

    if (_overlayEntry != null) {
      _overlayEntry.remove();
    }

    _overlayEntry = createOverlayEntry(context, icon, color, message);
    Overlay.of(context).insert(_overlayEntry);
    toastTimer = Timer(Duration(seconds: 3), () {
      if (_overlayEntry != null) {
        _overlayEntry.remove();
        toastTimer = null;
        _overlayEntry = null;
      }
    });
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, Icon icon, Color color, String message) {
    return OverlayEntry(
        builder: (context) => Positioned(
              bottom: 50.0,
              width: MediaQuery.of(context).size.width - 20,
              height: 56,
              left: 10,
              child: ToastMessageAnimation(Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "yekan"),
                        ),
                        icon
                      ],
                    ),
                  ),
                ),
              )),
            ));
  }

}
