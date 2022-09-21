import 'package:flutter/material.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';

import 'divider.dart';
import 'dynamicFontSize.dart';
import 'heigh_sized_box.dart';

class CustomNotificationTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final bool isChat;
  final int counter;

  CustomNotificationTile(
      {@required this.image,
      @required this.title,
      @required this.description,
      @required this.time,
      this.counter,
      this.isChat = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: DynamicFontSize(
                label: title,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: DynamicFontSize(
                label: description,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0x991A1A1A),
              ),
            ),
            trailing: _getBadge(counter)),
        CustomDivider()
      ],
    );
  }

  _getBadge(int counter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DynamicFontSize(
          label: time,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0x991A1A1A),
        ),
        if (counter != 0) VerticalSpace(3),
        if (counter != 0)
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: FrontEndConfigs.appBaseColor),
            child: Center(
              child: Text(
                counter.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }
}
