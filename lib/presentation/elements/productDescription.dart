import 'package:flutter/material.dart';
import '/presentation/elements/dynamicFontSize.dart';

class ProductDescription extends StatelessWidget {
  final String text;
  ProductDescription(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DynamicFontSize(
            label: text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xffB2B2B2),
            lineHeight: 1.6,
            isAlignCenter: false,
          ),
        ],
      ),
    );
  }
}
