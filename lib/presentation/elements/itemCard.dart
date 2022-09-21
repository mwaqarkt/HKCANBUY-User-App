import 'package:flutter/material.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/presentation/elements/orderDetailTile.dart';

class ItemCard extends StatelessWidget {
  final CartList cartModel;
  final UserDetailsModel userDetailsModel;
  final bool isComplete;
  final VoidCallback onOrderTap;

  const ItemCard(
      {Key key,
      this.cartModel,
      this.userDetailsModel,
      this.onOrderTap,
      this.isComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OrderDetailTile(
        cartModel: cartModel,
        isComplete: isComplete,
        userDetailsModel: userDetailsModel,
      ),
    );
  }
}
