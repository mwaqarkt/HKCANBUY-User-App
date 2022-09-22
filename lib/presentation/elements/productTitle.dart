import 'package:flutter/material.dart';

import 'dynamicFontSize.dart';

class ProductTitle extends StatelessWidget {
  final String text;
  ProductTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: DynamicFontSize(
          label: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
