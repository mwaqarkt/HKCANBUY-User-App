import 'package:flutter/material.dart';

class ProductSizeLocalModel {
  final int index;
  final String label;
  final TextEditingController value;
  final TextEditingController quantity;

  ProductSizeLocalModel({this.label, this.value, this.index, this.quantity});
}
