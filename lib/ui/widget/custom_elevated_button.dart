import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';

import '../../utils/app_config.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({super.key, required this.child, required this.onTap,this.color= AppColor.yellowColor});

  Widget child;
  VoidCallback onTap;
  Color color;
  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: height * 0.017),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),

      onPressed: onTap,
      child: child,
    );
  }
}