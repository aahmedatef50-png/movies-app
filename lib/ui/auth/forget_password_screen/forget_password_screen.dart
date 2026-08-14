import 'package:flutter/material.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/auth/auth_validation.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/ui/widget/custom_text_elevated_button.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_config.dart';
import '../../widget/custom_text_form_feild.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.forget_password,
          style: AppStyle.reg16Yellow,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColor.yellowColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.01,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppImage.forgetPasswordBg,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                CustomTextFormFeild(
                  onValidator: (text) {
                    return AuthValidation.emailValidator(text, context);
                  },
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: ImageIcon(
                    AssetImage(AppImage.emailIcon),
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(height: height * 0.03),
                CustomElevatedButton(
                  onTap: resetPassword,
                  child: CustomTextElevatedButton(
                    text: AppLocalizations.of(context)!.verify_email,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() {
    if (_formKey.currentState?.validate() == true) {
      //todo:reset password
    }
  }
}
