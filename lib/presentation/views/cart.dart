import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/application/cartProvider.dart';
import '/infrastructure/models/orderModel.dart';
import '/infrastructure/services/cartServices.dart';
import '/presentation/elements/appBar.dart';
import '/presentation/elements/appButton.dart';
import '/presentation/elements/cartTile.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/loading_widget.dart';
import '/presentation/elements/noData.dart';
import '/presentation/views/locationList.dart';

class CartView extends StatelessWidget {
  CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);

    return StreamProvider<List<CartList>>.value(
      initialData: [],
      value:
          _cartServices.streamCartList(FirebaseAuth.instance.currentUser!.uid),
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
