import 'package:flutter/material.dart';

class ProductFeaturesModel {
  int index;
  TextEditingController label;
  TextEditingController chLabel;
  List value;

  ProductFeaturesModel({
    this.label,
    this.value,
    this.index,
    this.chLabel,
  });
}

class ProductFeaturesJsonModel {
  String label;
  String chLabel;
  List value;

  ProductFeaturesJsonModel({
    this.label,
    this.value,
    this.chLabel,
  });

  ProductFeaturesJsonModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    chLabel = json['chLabel'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['chLabel'] = this.chLabel;
    data['value'] = this.value;
    return data;
  }
}
