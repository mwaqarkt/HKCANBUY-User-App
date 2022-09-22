import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/configurations/frontEndConfigs.dart';
import '/infrastructure/models/productModel/completeProductModel.dart';
import '/infrastructure/services/productServices.dart';
import '/presentation/elements/ratingRow.dart';
import '/presentation/views/productDetailsScreen.dart';

import 'heigh_sized_box.dart';
import 'horizontal_sized_box.dart';
import 'loading_widget.dart';

class ProductCard extends StatefulWidget {
  final int index;
  final CompleteProductModel productModel;

  ProductCard({
    required this.index,
    required this.productModel,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  ProductServices _productServices = ProductServices();

  late DateTime dateTime;

  @override
  void initState() {
    // TODO: implement initState
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBoxDecoration(context, i: widget.index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dateTime.difference(widget
                          .productModel.productGeneralDetailsModel!.productTime
                          .toDate()) <=
                      Duration(days: 1)
                  ? _getNewBadge("new")
                  : Container(
                      height: 1,
                      width: 1,
                    ),
            ],
          ),
          VerticalSpace(5),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(widget.productModel)));
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AddToCart()));
            },
            child: Column(
              children: [
                Stack(
                  // overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Color(0xffF8D4D3), shape: BoxShape.circle),
                    ),
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: CachedNetworkImage(
                            imageUrl: widget.productModel
                                .productGeneralDetailsModel!.image![0],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => LoadingWidget(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          widget.productModel.productGeneralDetailsModel!
                              .productName!,
                          style: Theme.of(context).textTheme.caption!.merge(
                              TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingRow(widget
                          .productModel.productGeneralDetailsModel!.rating
                          .toDouble()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (widget.productModel.discountModel!.isOnDiscount!)
                        Text(
                          "\$${int.parse(widget.productModel.sizePriceQuantityModel![0].value!)}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough),
                        ),
                      HorizontalSpace(4),
                      if (widget.productModel.discountModel!.isOnDiscount!)
                        Text(
                            "\$${(int.parse(widget.productModel.discountModel!.discountPercentage!) * (int.parse(widget.productModel.sizePriceQuantityModel![0].value!) / 100)).toStringAsFixed(1)}"),
                      if (!widget.productModel.discountModel!.isOnDiscount!)
                        Text(
                          "\$${widget.productModel.sizePriceQuantityModel![0].value}",
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getBoxDecoration(BuildContext context, {int? i}) {
    if (i != -1) {
      return BoxDecoration(
        border: widget.index % 2 != 0
            ? Border(
                left: BorderSide(color: FrontEndConfigs.borderColor),
                bottom: BorderSide(color: FrontEndConfigs.borderColor),
              )
            : Border(
                bottom: BorderSide(color: FrontEndConfigs.borderColor),
              ),
      );
    } else {
      return BoxDecoration(
          border: Border(
        right: BorderSide(color: FrontEndConfigs.borderColor),
        bottom: BorderSide(color: FrontEndConfigs.borderColor),
      ));
    }
  }

  Widget _getNewBadge(String text) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Text(
            text.tr(),
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ),
      ),
    );
  }
}
