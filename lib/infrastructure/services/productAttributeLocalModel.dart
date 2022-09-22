import 'package:flutter/material.dart';

class ProductAttributes {
  final int index;
  final TextEditingController label;
  final TextEditingController chLabel;
  final List value;

  ProductAttributes({
    required this.index,
    required this.label,
    required this.chLabel,
    required this.value,
  });
}
