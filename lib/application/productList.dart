import 'package:flutter/cupertino.dart';
import '/infrastructure/models/productModel/completeProductModel.dart';

class ProductProvider extends ChangeNotifier {
  List<CompleteProductModel> _productList = [];

  void setProductList(List<CompleteProductModel> productList) {
    _productList = productList;
    notifyListeners();
  }

  List<CompleteProductModel> get getProducts => _productList;
}
