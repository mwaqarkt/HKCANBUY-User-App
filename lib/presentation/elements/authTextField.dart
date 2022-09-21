import 'package:flutter/material.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';

import 'dynamicFontSize.dart';
import 'heigh_sized_box.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final double letterSpacing;
  final bool showSuffix;
  final VoidCallback onEditingComplete;
  final TextEditingController controller;
  final Function(String) validator;

  AuthTextField(
      {this.label,
      this.letterSpacing = 0.3,
      this.validator,
      this.controller,
      this.showSuffix = false,
      this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DynamicFontSize(
            label: label,
            fontFamily: "Inter",
            letterSpacing: 0.5,
            color: Color(0xff3A3D46),
            fontSize: 10,
            fontWeight: FontWeight.w700),
        VerticalSpace(5),
        Container(
          height: 56,
          child: TextFormField(
            validator: (val) => validator(val),
            controller: controller,
            onEditingComplete: () => onEditingComplete(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: letterSpacing,
                fontFamily: "Inter",
                fontSize: 16,
                color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: showSuffix
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 19.0, top: 19, bottom: 19, right: 10),
                        child: Image.asset('assets/icons/searchCross.png'),
                      )
                    : null,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: FrontEndConfigs.borderColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: FrontEndConfigs.borderColor)),
                labelStyle: TextStyle(
                    letterSpacing: 1,
                    color: Color(0xff3A3D46),
                    fontSize: 10,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }
}
