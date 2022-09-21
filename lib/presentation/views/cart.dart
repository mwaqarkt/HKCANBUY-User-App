import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/cartProvider.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/infrastructure/services/cartServices.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/appButton.dart';
import 'package:user_app/presentation/elements/cartTile.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/elements/noData.dart';
import 'package:user_app/presentation/views/locationList.dart';

class CartView extends StatelessWidget {
  CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    var user = Provider.of<User>(context);
    return StreamProvider.value(
      value: _cartServices.streamCartList(user.uid),
      builder: (ctxt, child) {
        return Scaffold(
          appBar: customAppBar(context, text: "Cart", onTap: () {
            Navigator.pop(context);
          }),
          body: ctxt.watch<List<CartList>>() == null
              ? LoadingWidget()
              : ctxt.watch<List<CartList>>().isEmpty
                  ? Center(child: NoData())
                  : ListView.builder(
                      itemCount: ctxt.watch<List<CartList>>().length,
                      itemBuilder: (context, i) {
                        return CartTile(
                          model: ctxt.watch<List<CartList>>()[i],
                        );
                      }),
          bottomNavigationBar: ctxt.watch<List<CartList>>() == null
              ? Container(
                  height: 1,
                  width: 1,
                )
              : ctxt.watch<List<CartList>>().isEmpty
                  ? Container(
                      height: 1,
                      width: 1,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          text: "Proceed to Checkout",
                          isDark: true,
                          onTap: () {
                            cart.add(ctxt.read<List<CartList>>());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationListView()));
                          },
                        ),
                        VerticalSpace(10),
                      ],
                    ),
        );
      },
    );
  }
}
