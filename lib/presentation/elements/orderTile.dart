import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;

import '/configurations/frontEndConfigs.dart';
import '/infrastructure/models/orderModel.dart';
import 'dynamicFontSize.dart';
import 'heigh_sized_box.dart';
import 'horizontal_sized_box.dart';

class CustomOrderTile extends StatelessWidget {
  final OrderDetailsModel orderModel;
  final VoidCallback onOrderTap;
  const CustomOrderTile({
    Key? key,
    required this.orderModel,
    required this.onOrderTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: FrontEndConfigs.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      HorizontalSpace(10),
                      HorizontalSpace(10),
                      Text(
                        "",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .merge(TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: FrontEndConfigs.appBaseColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _getOrderStatus().tr(),
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ))
                ],
              ),
              VerticalSpace(10),
              Divider(),
              VerticalSpace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DynamicFontSize(
                            label: orderModel.userDetailsModel!.firstName! +
                                " " +
                                orderModel.userDetailsModel!.lastName!,
                            fontSize: 12),
                        VerticalSpace(8),
                        DynamicFontSize(
                          label: orderModel.userDetailsModel!.email!,
                          fontSize: 11,
                          color: Theme.of(context).textTheme.caption!.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              VerticalSpace(10),
              Divider(),
              VerticalSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID #${orderModel.orderID}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          date.DateFormat('yyyy-MM-dd hh:mm').format(
                              DateTime.parse(orderModel.placementDate!)),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => onOrderTap(),
                      child: Container(
                          decoration: BoxDecoration(
                              color: orderModel.isCancelled!
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10),
                            child: Text(
                              "check_details".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              VerticalSpace(10),
              Divider(),
              VerticalSpace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "total".tr(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Bill".tr(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "\$ " + orderModel.totalPrice.toString() ?? "N/A",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getOrderStatus() {
    if (orderModel.isActive == true) {
      return "processed_order";
    } else if (orderModel.isPending == true) {
      return "awaiting_response";
    } else if (orderModel.isComplete == true) {
      return "completed_orders";
    } else if (orderModel.isCancelled == true) {
      return "cancelled_orders";
    } else if (orderModel.isReady == true) {
      return "ready_for_pickup";
    } else {
      return "";
    }
  }

  String _getOrderPlacementStatus() {
    if (orderModel.isActive == true) {
      return "Placed Order";
    } else if (orderModel.isPending == true) {
      return "Awaiting Response";
    } else if (orderModel.isComplete == true) {
      return "completed_orders";
    } else if (orderModel.isCancelled == true) {
      return "cancelled_orders";
    } else {
      return "";
    }
  }
}
