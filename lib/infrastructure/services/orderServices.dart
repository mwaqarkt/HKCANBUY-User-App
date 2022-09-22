import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/application/app_state.dart';
import '/infrastructure/models/orderModel.dart';

class OrderServices {
  ///Create Order
  Future<void> createOrder(BuildContext context,
      {required OrderDetailsModel model,required String userID}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('orderCollection').doc();
    await docRef.set(model.toJson(docRef.id));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  ///Get My Orders
  Stream<List<OrderDetailsModel>> streamMyOrders(String uid) {
    return FirebaseFirestore.instance
        .collection('orderCollection')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) => event.docs
            .map((e) => OrderDetailsModel.fromJson(e.data()))
            .toList());
  }
}
