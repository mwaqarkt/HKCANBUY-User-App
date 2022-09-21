import 'package:flutter/material.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';

import 'dynamicFontSize.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool isDark;
  final VoidCallback onTap;

  AppButton({this.text, this.isDark, this.onTap});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: FrontEndConfigs.buttonColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Center(
                      child: DynamicFontSize(
                    label: text,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: isDark
                        ? Colors.white
                        : Theme.of(context).textTheme.headline6.color,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
