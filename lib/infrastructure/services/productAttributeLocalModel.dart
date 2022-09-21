import 'package:flutter/material.dart';

class ProductAttributes {
  final int index;
  final TextEditingController label;
  final TextEditingController chLabel;
  final List value;

  ProductAttributes({this.label, this.value, this.index, this.chLabel});
}
