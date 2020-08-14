import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.white24,
    gravity: ToastGravity.CENTER,
  );
}
