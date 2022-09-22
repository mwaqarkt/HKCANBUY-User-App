import 'package:flutter/material.dart';

class ProductSizeLocalModel {
  final int index;
  final String label;
  final TextEditingController value;
  final TextEditingController quantity;

  ProductSizeLocalModel({
    required this.index,
    required this.label,
    required this.value,
    required this.quantity,
  });
}
