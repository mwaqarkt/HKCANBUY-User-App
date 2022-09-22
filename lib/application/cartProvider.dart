import 'package:flutter/cupertino.dart';
import '/infrastructure/models/orderModel.dart';

class CartProvider extends ChangeNotifier {
  List<CartList> list = [];

  void add(List<CartList> _list) {
    list = _list;
    notifyListeners();
  }

  List<CartList> get cartList => list;

  void clearList() {
    list.clear();
    notifyListeners();
  }
}
