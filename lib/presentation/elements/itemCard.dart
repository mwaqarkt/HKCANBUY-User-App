import 'package:flutter/material.dart';

import '/infrastructure/models/orderModel.dart';
import '/presentation/elements/orderDetailTile.dart';

class ItemCard extends StatelessWidget {
  final CartList cartModel;
  final UserDetailsModel userDetailsModel;
  final bool isComplete;
  final VoidCallback onOrderTap;
  const ItemCard({
    Key? key,
    required this.cartModel,
    required this.userDetailsModel,
    required this.isComplete,
    required this.onOrderTap,
  }) : super(key: key);

 

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
