import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_config.dart';
import '../../utils/app_image.dart';

typedef OnClick = void Function(bool);

class CustomAnimatedSwitch extends StatelessWidget {
  CustomAnimatedSwitch({
    super.key,
    required this.switchWidget,
    required this.onClick,
  });

  bool switchWidget;
  OnClick onClick;

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return AnimatedToggleSwitch.dual(
      current: switchWidget,
      first: false,
      second: true,
      height: height * 0.05,
      borderWidth: 2,
      onChanged: onClick,
      spacing: width * 0.05,
      animationDuration: Duration(milliseconds: 400),
      iconBuilder: (value) {
        return Image.asset(
          value ? AppImage.egyptFlag : AppImage.unitedStateFlag,
          height: height * 0.043,
        );
      },
      textBuilder: (value) {
        return Image.asset(
          value ? AppImage.unitedStateFlag : AppImage.egyptFlag,
          height: height * 0.039,
        );
      },
      style: ToggleStyle(
        indicatorBorder: BoxBorder.all(color: AppColor.yellowColor, width: 3),
        borderColor: AppColor.yellowColor,
        backgroundColor: AppColor.blackColor,
      ),
    );
  }
}
