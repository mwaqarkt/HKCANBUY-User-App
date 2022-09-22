import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

customFlushBar(BuildContext context, {required String errorString}) {
  return Flushbar(
    message: errorString,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.red[300],
    ),
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: Duration(seconds: 3),
  )..show(context);
}
