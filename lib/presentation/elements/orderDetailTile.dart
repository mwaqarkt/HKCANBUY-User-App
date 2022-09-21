import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/navigation_dialog.dart';
import 'package:user_app/presentation/views/rating_view.dart';

class OrderDetailTile extends StatelessWidget {
  final CartList cartModel;
  final UserDetailsModel userDetailsModel;
  final bool isComplete;

  OrderDetailTile({this.cartModel, this.isComplete, this.userDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffF4F5F7), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              cartModel.productDetails.productImage,
            ),
          ),
          title: Text(
            cartModel.productDetails.productName,
            style: Theme.of(context).textTheme.caption.merge(
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartModel.totalPrice.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "quantity ".tr(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cartModel.quantity.toString(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          trailing: isComplete
              ? IconButton(
                  icon: Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    showNavigationDialog(context,
                        message: "Do you really want to rate our product?",
                        buttonText: "Yes", navigation: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RatingView(
                                    userID: userDetailsModel.uid,
                                    productID: cartModel.productDetails.docID,
                                    name: userDetailsModel.firstName +
                                        " " +
                                        userDetailsModel.lastName,
                                  )));
                    }, secondButtonText: "No", showSecondButton: true);
                  },
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
