import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/infrastructure/models/orderModel.dart';
import '/infrastructure/services/orderServices.dart';
import '/presentation/elements/appBar.dart';
import '/presentation/elements/divider.dart';
import '/presentation/elements/loading_widget.dart';
import '/presentation/elements/noData.dart';
import '/presentation/elements/orderTile.dart';

import 'order_details_view.dart';

class UsersOrders extends StatefulWidget {
  @override
  _UsersOrdersState createState() => _UsersOrdersState();
}

class _UsersOrdersState extends State<UsersOrders> {
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: "My Orders", onTap: () {
        Navigator.pop(context);
      }),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<User>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomDivider(),
        StreamProvider.value(
          initialData: [],
          value: _orderServices.streamMyOrders(user.uid),
          builder: (context, child) {
            return context.watch<List<OrderDetailsModel>>() == null
                ? Container(
                    height: MediaQuery.of(context).size.height - 150,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: LoadingWidget()),
                      ],
                    ),
                  )
                : context.watch<List<OrderDetailsModel>>().length != 0
                    ? Expanded(
                        child: ListView.builder(
                            itemCount:
                                context.watch<List<OrderDetailsModel>>().length,
                            itemBuilder: (context, i) {
                              return CustomOrderTile(
                                  onOrderTap: () {
                                    OrderDetailsModel model = context
                                        .read<List<OrderDetailsModel>>()[i];
                                    setState(() {});
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsView(model)));
                                  },
                                  orderModel: context
                                      .read<List<OrderDetailsModel>>()[i]);
                            }))
                    : NoData();
          },
        )
      ],
    );
  }
}
