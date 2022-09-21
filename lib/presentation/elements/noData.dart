import 'package:flutter/material.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';

import 'dynamicFontSize.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            color: Colors.grey[400],
            size: 65,
          ),
          VerticalSpace(10),
          Center(
            child: DynamicFontSize(
              label: "no_data_found",
              color: Colors.grey[400],
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
