import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/app_state.dart';
import 'package:user_app/application/locationProvider.dart';
import 'package:user_app/application/productDetailsProvider.dart';
import 'package:user_app/application/userDetails.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/infrastructure/services/cartServices.dart';
import 'package:user_app/infrastructure/services/orderServices.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/appButton.dart';
import 'package:user_app/presentation/elements/detail_text_field.dart';
import 'package:user_app/presentation/elements/divider.dart';
import 'package:user_app/presentation/elements/dynamicFontSize.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/views/order_details_view.dart';

class CheckOrderDetailsForUser extends StatefulWidget {
  final OrderDetailsModel orderModel;

  CheckOrderDetailsForUser(this.orderModel);

  @override
  _CheckOrderDetailsForUserState createState() =>
      _CheckOrderDetailsForUserState();
}

class _CheckOrderDetailsForUserState extends State<CheckOrderDetailsForUser> {
  TextEditingController _customerSideNote = TextEditingController();
  TextEditingController _adminSideNote;

  OrderServices _orderServices = OrderServices();
  CartServices _cartServices = CartServices();

  @override
  initState() {
    _customerSideNote = TextEditingController(
        text: widget.orderModel.noteFromUserModel.comment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: "order_details", onTap: () {
        Navigator.pop(context);
      }),
      body: _getUI(context),
    );
  }

  ProgressDialog pr;

  Widget _getUI(BuildContext context) {
    var status = Provider.of<AppState>(context);
    pr = ProgressDialog(context, isDismissible: true);
    pr.style(message: "Processing...");
    UserDetailsProvider userDetailsProvider =
        Provider.of<UserDetailsProvider>(context);
    ProductDetailsProvider productDetailsProvider =
        Provider.of<ProductDetailsProvider>(context);
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDivider(),
          VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: "customer_details",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          _getOrderRow(
              label: "first_name",
              text: widget.orderModel.userDetailsModel.firstName),
          _getOrderRow(
              label: "last_name",
              text: widget.orderModel.userDetailsModel.lastName),
          _getOrderRow(
              label: "contact_number",
              text: widget.orderModel.userDetailsModel.contactNumber),
          _getOrderRow(
              label: "email", text: widget.orderModel.userDetailsModel.email),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: "order_details",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          _getOrderRow(
              label: "product_name",
              text: widget.orderModel.userDetailsModel.firstName +
                  " " +
                  widget.orderModel.userDetailsModel.lastName),
          _getOrderRow(label: "quantity", text: widget.orderModel.orderID),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: "pickup_details",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          _getOrderRow(
              label: "pick_up_location",
              text: widget.orderModel.locationDetailsModel.pickupLocation),
          _getOrderRow(
              label: "selected_pickup_day",
              text: widget.orderModel.locationDetailsModel.selectedPickUpDay),
          _getOrderRow(
              label: "selected_pickup_time",
              text: widget.orderModel.locationDetailsModel.selectedPickUpTime),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: "total_payable",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          VerticalSpace(20),
          CustomDivider(),
          VerticalSpace(20),
          _getOrderRow(
              label: "total_payable", text: "\$${widget.orderModel.orderID}"),
          VerticalSpace(10),
          CustomDivider(),
          VerticalSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: "add_note",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          VerticalSpace(10),
          CustomDivider(),
          VerticalSpace(10),
          DetailTextField(
            data: _customerSideNote,
            label: "add_note",
            enabled: false,
            maxLines: 3,
          ),
          VerticalSpace(10),
          Center(
            child: AppButton(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsView(widget.orderModel)));
              },
              text: "Check current status",
              isDark: true,
            ),
          ),
          VerticalSpace(20),
        ],
      ),
    );
  }

  _getOrderRow({String label, String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: text,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  _getColorContainer({String label, int colorCode}) {
    print("Color Code : $colorCode");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: DynamicFontSize(
              label: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              height: 48,
              width: 68,
              decoration: BoxDecoration(
                color: Color(colorCode),
                border: Border.all(color: Color(0xffECECEC)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
