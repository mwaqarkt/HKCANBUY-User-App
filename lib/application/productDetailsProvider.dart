import 'package:flutter/cupertino.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';

class ProductDetailsProvider extends ChangeNotifier {
  ProductDetails _details = ProductDetails();

  void setProductDetails(ProductDetails details) {
    _details = details;
    notifyListeners();
  }

  ProductDetails get getProductDetails => _details;
}
