import 'package:flutter/material.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';
import 'package:user_app/presentation/elements/dynamicFontSize.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            color: FrontEndConfigs.buttonColor,
            size: 85,
          ),
          VerticalSpace(20),
          DynamicFontSize(
            label: "User App",
            fontSize: 30,
            color: Color(0xff2f77bf),
          ),
          VerticalSpace(20),
          LoadingWidget()
        ],
      ),
    );
  }
}
