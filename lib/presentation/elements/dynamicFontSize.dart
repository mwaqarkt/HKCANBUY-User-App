import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DynamicFontSize extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color color;
  final bool isBold;
  final bool isAlignCenter;
  final double lineHeight;
  final bool isUnderline;
  final FontWeight fontWeight;
  final double letterSpacing;
  final String fontFamily;
  DynamicFontSize({
    this.label,
    this.fontSize,
    this.isAlignCenter = true,
    this.isBold = false,
    this.isUnderline = false,
    this.lineHeight = 1.0,
    this.letterSpacing = 0.5,
    this.fontFamily = "Poppins",
    this.fontWeight = FontWeight.bold,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      label.tr(),
      textAlign: isAlignCenter ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        letterSpacing: letterSpacing,
        height: lineHeight,
        fontFamily: fontFamily,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
