import 'package:flutter/material.dart';
import '/infrastructure/services/cartServices.dart';

class CartBusinessLogics {
  CartServices _cartServices = CartServices();

  ///Check if product already exists
  Future<bool> checkIfProductAlreadyExists(
      {required String productID, required String uid}) async {
    print("Product ID : $productID");
    return await _cartServices
        .streamSpecificProduct(productID, uid)
        .first
        .then((value) {
      if (value.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }
}
