import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';

import '../../utils/size_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isFilled = true,
  });

  Widget child;
  VoidCallback onTap;
  bool isFilled;

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: height * 0.017),
        backgroundColor: isFilled ? AppColor.yellowColor : AppColor.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isFilled ? AppColor.transparentColor : AppColor.yellowColor,
          ),
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
