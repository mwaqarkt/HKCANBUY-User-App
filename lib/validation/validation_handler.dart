import 'package:flutter/material.dart';

class ValidationHandler {
  static validateInput(
      {@required String returnString, @required String inputValue}) {
    if (inputValue.isEmpty) {
      return returnString;
    } else {
      return null;
    }
  }
}
