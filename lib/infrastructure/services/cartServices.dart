import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/app_state.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';

class CartServices {
  ///Display Cart List
  Stream<List<CartList>> streamCartList(String uid) {
    return FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(uid)
        .collection('myCart')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CartList.fromJson(e.data())).toList());
  }

  ///Add to Cart
  Future<void> addToCart(BuildContext context,
      {CartList model, String uid}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(uid)
        .collection('myCart')
        .doc();
    await docRef.set(model.toJson(docRef.id));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Remove From Cart
  Future<void> removeFromCart(String docID, String uid) async {
    return FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(uid)
        .collection('myCart')
        .doc(docID)
        .delete();
  }

  ///Increment Quantity
  Future<void> incrementProductQuantity(BuildContext context,
      {String productID, int updatedPrice, String uid}) async {
    FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(uid)
        .collection('myCart')
        .doc(productID)
        .update(
            {'quantity': FieldValue.increment(1), 'totalPrice': updatedPrice});
  }

  ///Decrement Quantity
  Future<void> decrementProductQuantity(BuildContext context,
      {String productID, int updatedPrice, String uid}) async {
    FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(uid)
        .collection('myCart')
        .doc(productID)
        .update(
            {'quantity': FieldValue.increment(-1), 'totalPrice': updatedPrice});
  }

  ///Check specific Product
  Stream<List<CartList>> streamSpecificProduct(String productID, String uid) {
    print("UID : $uid");
    print("Product ID : $productID");
    return FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(uid)
        .collection('myCart')
        .where('productDetails.docID', isEqualTo: productID)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CartList.fromJson(e.data())).toList());
  }

  ///Empty My Cart
  Future<void> emptyMyCart({String docID, String userID}) async {
    print("User ID : $userID");
    return FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(userID)
        .collection('myCart')
        .doc(docID)
        .delete();
  }

  ///Delete Specific Item
  Future<void> deleteOneItem({String docID, String userID}) async {
    print("User ID : $userID");
    return FirebaseFirestore.instance
        .collection('cartCollection')
        .doc(userID)
        .collection('myCart')
        .doc(docID)
        .delete();
  }
}
