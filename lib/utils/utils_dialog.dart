import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/size_utils.dart';

class UtilsDialog {
  static void showLoading({
    required BuildContext context,
    required String content,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.darkGreyColor,
          content: Row(
            spacing: AppConfig.width(context) * 0.03,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColor.yellowColor),
              Text(content, style: AppStyle.bold20Yellow),
            ],
          ),
        );
      },
    );
  }

  static void hideDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String content,
    required String title,
    String? posAction,
    String? negAction,
    VoidCallback? negActions,
    VoidCallback? posActions,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        List<Widget> actions = [];
        if (posAction != null) {
          actions.add(
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                posActions?.call();
              },
              child: Text(posAction, style: AppStyle.reg16Yellow),
            ),
          );
        }
        if (negAction != null) {
          actions.add(
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                negActions?.call();
              },
              child: Text(negAction, style: AppStyle.reg16Yellow),
            ),
          );
        }
        return AlertDialog(
          backgroundColor: AppColor.darkGreyColor,
          content: Text(content, style: AppStyle.bold20Yellow),
          title: Text(title, style: AppStyle.reg16Yellow),
          actions: actions,
        );
      },
    );
  }
}
