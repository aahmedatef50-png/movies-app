import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_config.dart';
import '../../utils/app_image.dart';
import 'custom_elevated_button.dart';
import 'custom_text_elevated_button.dart';
import 'custom_text_form_feild.dart';

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({required this.passwordController, required this.onClick});

  TextEditingController passwordController;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.03,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: height * 0.03,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: height * 0.01),
          CustomTextFormFeild(
            controller: passwordController,
            hintText: 'confirm password',
            prefixIcon: ImageIcon(
              AssetImage(AppImage.lockIcon),
              color: AppColor.whiteColor,
            ),
          ),
          CustomElevatedButton(
            child: CustomTextElevatedButton(text: 'confirmPassword'),
            onTap: onClick,
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}
