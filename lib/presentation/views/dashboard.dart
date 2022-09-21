import 'package:flutter/material.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/views/getMyOrders.dart';
import 'package:user_app/presentation/views/homePage.dart';
import 'package:user_app/presentation/views/viewCategories.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: "Dashbaord"),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UsersOrders()));
          },
          child: Text("Get My Orders"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Text("Continue Shopping"),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => StepperDemo()));
          },
          child: Text("Order Status"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewCategories()));
          },
          child: Text("View Categories"),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => StepperDemo()));
          },
          child: Text("Logout"),
        ),
      ],
    );
  }
}
