import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showNavigationDialog(BuildContext context,
    {required String message,
    required String buttonText,
    required VoidCallback navigation,
    required String secondButtonText,
    required bool showSecondButton}) async {
  showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "message".tr(),
            style: TextStyle(color: Colors.green[900]),
          ),
          content: Text(message.tr()),
          actions: [
            TextButton(
                onPressed: () => navigation(), child: Text(buttonText.tr())),
            if (showSecondButton == true)
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(secondButtonText.tr()))
          ],
        );
      });
}
