import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';

import 'horizontal_sized_box.dart';

customAppBar(BuildContext context,
    {String text,
    bool showFilter = false,
    VoidCallback onTap,
    bool showArrow = true}) {
  return AppBar(
    title: Text(
      text.tr(),
      style: TextStyle(
          color: FrontEndConfigs.darkTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 22),
    ),
    leading: showArrow
        ? IconButton(
            onPressed: () => onTap(),
            icon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
          )
        : Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu, size: 28, color: Colors.black),
              );
            },
          ),
    centerTitle: true,
    actions: [
      if (showFilter)
        Image.asset(
          'assets/images/Filter.png',
          height: 24,
          width: 24,
        ),
      if (showFilter) HorizontalSpace(24)
    ],
  );
}
