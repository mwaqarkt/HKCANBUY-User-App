import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/application/cartBznzLogic.dart';
import '/configurations/frontEndConfigs.dart';
import '/infrastructure/models/orderModel.dart';
import '/infrastructure/services/cartServices.dart';
import '/presentation/elements/divider.dart';

import 'horizontal_sized_box.dart';

class CartTile extends StatefulWidget {
  final CartList model;

  CartTile({required this.model});

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  CartServices _cartServices = CartServices();
  CartBusinessLogics _cartBusinessLogics = CartBusinessLogics();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HorizontalSpace(10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    isThreeLine: false,
                    leading: _buildLeading(),
                    title: Text(widget.model.productDetails!.productName!),
                    subtitle: _buildSubTitle(context,
                        list: widget.model.productDetails!.perQuantityPrice!),
                  ),
                )
              ],
            ),
          ),
        ),
        CustomDivider()
      ],
    );
  }

  Widget _buildLeading() {
    return Stack(
      // overflow: Overflow.visible,
      children: [
        Container(
          width: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.model.productDetails!.productImage!),
                  fit: BoxFit.cover),
              color: Color(0xffF8D4D3),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }

  Widget _buildSubTitle(BuildContext context, {@required var list}) {
    var user = Provider.of<User>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "\$${int.parse(widget.model.productDetails!.perQuantityPrice!) * widget.model.quantity!}"),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (widget.model.quantity == 1) {
                      _cartServices.deleteOneItem(
                          userID: user.uid, docID: widget.model.docID!);
                    }
                    if (widget.model.quantity !> 1)
                      _cartServices.decrementProductQuantity(context,
                          uid: user.uid,
                          productID: widget.model.docID!,
                          updatedPrice: int.parse(widget
                                  .model.productDetails!.perQuantityPrice!) *
                              (widget.model.quantity !+ 1));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: FrontEndConfigs.borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.remove,
                        size: 13,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(widget.model.quantity.toString()),
                ),
                InkWell(
                  onTap: () {
                    _cartServices.incrementProductQuantity(context,
                        productID: widget.model.docID!,
                        uid: user.uid,
                        updatedPrice: int.parse(
                                widget.model.productDetails!.perQuantityPrice!) *
                            (widget.model.quantity! + 1));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: FrontEndConfigs.borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.add,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
