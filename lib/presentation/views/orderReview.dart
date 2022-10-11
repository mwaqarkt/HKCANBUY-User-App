import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '/application/app_state.dart';
import '/application/cartProvider.dart';
import '/application/locationProvider.dart';
import '/application/notificationHandler.dart';
import '/application/productDetailsProvider.dart';
import '/application/userDetails.dart';
import '/infrastructure/models/orderModel.dart';
import '/infrastructure/services/cartServices.dart';
import '/infrastructure/services/orderServices.dart';
import '/infrastructure/services/productServices.dart';
import '/presentation/elements/appBar.dart';
import '/presentation/elements/appButton.dart';
import '/presentation/elements/detail_text_field.dart';
import '/presentation/elements/divider.dart';
import '/presentation/elements/dynamicFontSize.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/navigation_dialog.dart';
import '/presentation/views/homePage.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  TextEditingController _customerSideNote = TextEditingController();
  late TextEditingController _adminSideNote;
  CartServices _cartServices = CartServices();
  OrderServices _orderServices = OrderServices();
  NotificationHandler _notificationHandler = NotificationHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: "order_details", onTap: () {
        Navigator.pop(context);
      }),
      body: _getUI(context),
    );
  }

  ProductServices _productServices = ProductServices();
  // ProgressDialog? pr;

  Widget _getUI(BuildContext context) {
    var status = Provider.of<AppState>(context);
    // pr = ProgressDialog(context, isDismissible: true);
    // pr!.style(message: "Processing...");
    UserDetailsProvider userDetailsProvider =
        Provider.of<UserDetailsProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
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
              text: userDetailsProvider.getUserDetails.firstName!),
          _getOrderRow(
              label: "last_name",
              text: userDetailsProvider.getUserDetails.lastName!),
          _getOrderRow(
              label: "contact_number",
              text: userDetailsProvider.getUserDetails.contactNumber!),
          _getOrderRow(
              label: "email", text: userDetailsProvider.getUserDetails.email!),
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
          ...cartProvider.list.map((e) => _getOrderWidget(e)).toList(),
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
              text: locationProvider.getLocation.pickupLocation!),
          _getOrderRow(
              label: "selected_pickup_day",
              text: locationProvider.getLocation.selectedPickUpDay!),
          _getOrderRow(
              label: "selected_pickup_time",
              text: locationProvider.getLocation.selectedPickUpTime!),
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
              label: "total_payable",
              text: _getOrderTotalPrice(cartProvider.list).toString()),
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
            maxLines: 3,
          ),
          VerticalSpace(10),
          Center(
            child: AppButton(
              onTap: () async {
                // await pr!.show();
                var user = FirebaseAuth.instance.currentUser!;

                await _orderServices.createOrder(context,
                    userID: user.uid,
                    model: OrderDetailsModel(
                        placementDate: DateFormat('MM/dd/yyyy hh:mm a')
                            .format(DateTime.now()),
                        uid: user.uid,
                        cartList: cartProvider.list,
                        totalPrice: _getOrderTotalPrice(cartProvider.list),
                        locationDetailsModel: locationProvider.getLocation,
                        userDetailsModel: userDetailsProvider.getUserDetails,
                        noteFromUserModel: NoteFromUserModel(
                            comment: _customerSideNote.text, id: "")));

                if (status.getStateStatus() == StateStatus.IsFree) {
                  // await pr!.hide();
                  cartProvider.list
                      .map((e) => _cartServices.emptyMyCart(
                          docID: e.docID!, userID: user.uid))
                      .toList();
                  _notificationHandler.oneToOneNotificationHelper(
                      docID: "UdPCYhOQgGeLyMNCs7VpDmanRyH3",
                      body: "Kindly, check it and start processing.",
                      title: "New Order Placed!");
                  // _productServices.reduceStock(
                  //     productID: productDetailsProvider.getProductDetails.docID,
                  //     sizeID: productDetailsProvider.getProductDetails.sizeID);
                  showNavigationDialog(context,
                      message: "Order placed successfully.",
                      buttonText: "Okay", navigation: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (_) => false);
                  }, secondButtonText: "", showSecondButton: false);
                }
              },
              text: "Confirm and Place Order",
              isDark: true,
            ),
          ),
          VerticalSpace(20),
        ],
      ),
    );
  }

  _getOrderRow({required String label, required String text}) {
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

  _getColorContainer({required String label, required int colorCode}) {
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
                border: Border.all(color: Color(colorCode)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getOrderTotalPrice(List<CartList> list) {
    int totalPrice = 0;
    list.map((e) {
      totalPrice += e.totalPrice!;
      setState(() {});
    }).toList();

    return totalPrice;
  }

  _getOrderWidget(CartList model) {
    return Column(
      children: [
        _getOrderRow(
            label: "product_name", text: model.productDetails!.productName!),
        _getOrderRow(label: "quantity", text: model.quantity.toString()),
        _getOrderRow(label: "size", text: model.productDetails!.size!),
        _getOrderRow(label: "price", text: model.totalPrice.toString()),
        if (model.productDetails!.color != -1)
          _getColorContainer(
              label: "colour", colorCode: model.productDetails!.color!),
      ],
    );
  }
}
