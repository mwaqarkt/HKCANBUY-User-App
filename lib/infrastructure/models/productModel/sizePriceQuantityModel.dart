import 'package:flutter/cupertino.dart';

class SizePriceQuantityModel {
  int index;
  TextEditingController label;
  TextEditingController value;
  TextEditingController quantity;

  SizePriceQuantityModel({this.label, this.value, this.index, this.quantity});
}

class SizePriceQuantityJsonModel {
  String label;
  String value;
  String quantity;

  SizePriceQuantityJsonModel({this.label, this.value, this.quantity});

  SizePriceQuantityJsonModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    quantity = json['quantity'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['quantity'] = this.quantity;
    data['value'] = this.value;
    return data;
  }
}
