import 'package:flutter/material.dart';
import '/configurations/frontEndConfigs.dart';

// ignore: must_be_immutable
class DetailTextField extends StatelessWidget {
  String? initialValue;
  final TextEditingController data;
  final String label;
  int maxLines = 1;
  String? fontFamily;
  TextDirection textDirection;
 String? Function( String ?data)? validator;
  bool enabled;
  TextInputType keyBoardType;

  DetailTextField(
      {required this.data,
      required this.label,
      this.fontFamily,
      this.maxLines = 1,
      this.keyBoardType = TextInputType.text,
      this.initialValue,
      this.textDirection = TextDirection.ltr,
      this.validator,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: TextFormField(
          keyboardType: keyBoardType,
          controller: data,
          initialValue: initialValue,
          validator: validator,
          textDirection: textDirection,
          cursorColor: Colors.black,
          enabled: enabled,
          maxLines: maxLines,
          style: TextStyle(color: Colors.black),
          decoration: textFieldDecoration(label, context)),
    );
  }

  textFieldDecoration(String label, BuildContext context, [ String? hint]) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: FrontEndConfigs.borderColor));
    return InputDecoration(
        disabledBorder: outlineInputBorder,
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        hintText: hint == null ? '' : hint,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder);
  }
}
