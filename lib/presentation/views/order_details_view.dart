import 'package:flutter/material.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/appButton.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/itemCard.dart';
import 'package:user_app/presentation/views/orderStatus.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  OrderDetailsView(this.orderDetailsModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: "Order Details", onTap: () {
        Navigator.pop(context);
      }),
      body: _getUI(context),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                text: "Track your Order",
                isDark: true,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderStatus(orderDetailsModel)));
                },
              ),
            ],
          ),
          VerticalSpace(20),
        ],
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return ListView.builder(
        itemCount: orderDetailsModel.cartList.length,
        itemBuilder: (context, i) {
          return ItemCard(
              onOrderTap: () {},
              userDetailsModel: orderDetailsModel.userDetailsModel,
              cartModel: orderDetailsModel.cartList[i],
              isComplete: orderDetailsModel.isComplete);
        });
  }
}
