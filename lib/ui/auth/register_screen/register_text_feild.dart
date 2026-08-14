import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_config.dart';
import '../../../utils/app_image.dart';
import '../../widget/custom_text_form_feild.dart';
import '../auth_validation.dart';

class RegisterTextFeild extends StatelessWidget {
  RegisterTextFeild({
    super.key,
    required this.phoneController,
    required this.repasswordController,
    required this.passwordController,
    required this.emailController,
    required this.nameController,
    required this.obsure,
    required this.obscureText,
    required this.obsureRepass,
    required this.obscureRePassText,
  });

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController repasswordController;
  TextEditingController phoneController;
  bool obsure;
  bool obsureRepass;
  VoidCallback obscureText;
  VoidCallback obscureRePassText;

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    return Column(
      spacing: height * 0.02,
      children: [
        CustomTextFormFeild(
          hintText: AppLocalizations.of(context)!.name,
          prefixIcon: ImageIcon(
            AssetImage(AppImage.nameIcon),
            color: AppColor.whiteColor,
          ),
          controller: nameController,
          onValidator: (text) {
            return AuthValidation.nameValidator(text, context);
          },
        ),
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
        CustomTextFormFeild(
          textInputType: TextInputType.number,
          obscure: obsureRepass,
          hintText: AppLocalizations.of(context)!.confirm_password,
          prefixIcon: ImageIcon(
            AssetImage(AppImage.lockIcon),
            color: AppColor.whiteColor,
          ),
          suffixIcon: IconButton(
            onPressed: obscureRePassText,
            icon: Icon(
              obsureRepass
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: AppColor.whiteColor,
              size: 30,
            ),
          ),
          controller: repasswordController,
          onValidator: (text) {
            return AuthValidation.rePasswordValidator(
              text,
              context,
              passwordController,
            );
          },
        ),
        CustomTextFormFeild(
          textInputType: TextInputType.number,
          hintText: AppLocalizations.of(context)!.phone_number,
          prefixIcon: ImageIcon(
            AssetImage(AppImage.phoneIcon),
            color: AppColor.whiteColor,
          ),
          controller: phoneController,
          onValidator: (text) {
            return AuthValidation.phoneValidator(text, context);
          },
        ),
      ],
    );
  }
}
