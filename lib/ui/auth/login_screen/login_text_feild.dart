import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_config.dart';
import '../../../utils/app_image.dart';
import '../../widget/custom_text_form_feild.dart';
import '../auth_validation.dart';

class LoginTextFeild extends StatelessWidget {
  LoginTextFeild({
    super.key,
    required this.obsure,
    required this.obscureText,
    required this.emailController,
    required this.passwordController,
  });

  TextEditingController emailController;
  TextEditingController passwordController;
  VoidCallback obscureText;
  bool obsure;

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    return Column(
      spacing: height * 0.03,
      children: [
        CustomTextFormFeild(
          textInputType: TextInputType.emailAddress,
          hintText: AppLocalizations.of(context)!.email,
          prefixIcon: ImageIcon(
            AssetImage(AppImage.emailIcon),
            color: AppColor.whiteColor,
          ),
          controller: emailController,
          onValidator: (text) {
            return AuthValidation.emailValidator(text, context);
          },
        ),
        CustomTextFormFeild(
          obscure: obsure,
          textInputType: TextInputType.number,
          hintText: AppLocalizations.of(context)!.password,
          prefixIcon: ImageIcon(
            AssetImage(AppImage.lockIcon),
            color: AppColor.whiteColor,
          ),
          suffixIcon: IconButton(
            onPressed: obscureText,
            icon: Icon(
              obsure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: AppColor.whiteColor,
              size: 30,
            ),
          ),
          controller: passwordController,
          onValidator: (text) {
            return AuthValidation.passwordValidator(text, context);
          },
        ),
      ],
    );
  }
}
