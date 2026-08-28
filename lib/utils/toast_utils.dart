import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_style.dart';

class ToastUtils {
  static void showToastMessage({
    required String message,
    required BuildContext context,
    Color? color,
  }) {
    showToastWidget(
      Container(
        padding: EdgeInsets.all(AppConfig.width(context) * 0.02),
        decoration: BoxDecoration(
          color: color ?? AppColor.greenColor,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Text(message, style: AppStyle.bold20White),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTop,
      position: StyledToastPosition.center,
    );
  }
}
