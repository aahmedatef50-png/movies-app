import 'package:flutter/material.dart';
import 'package:icon_plus/icon_plus.dart';
import 'package:my_movies_app/ui/auth/login_screen/divider_or_widget.dart';
import 'package:my_movies_app/ui/auth/login_screen/login_text_feild.dart';
import 'package:my_movies_app/ui/widget/custom_animated_switch.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/ui/widget/custom_row_auth.dart';
import 'package:my_movies_app/ui/widget/custom_text_elevated_button.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool switchWidget = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: Column(
                spacing: height * 0.03,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppImage.moviesLogo, height: height * 0.2),
                  LoginTextFeild(
                    obsure: obsure,
                    obscureText: () {
                      if (obsure) {
                        obsure = false;
                      } else {
                        obsure = true;
                      }
                      setState(() {});
                    },
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoute.forgetPasswordScreen);
                        },
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.forget_password_question,
                          style: AppStyle.reg14Yellow,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onTap: login,
                    child: CustomTextElevatedButton(
                      text: AppLocalizations.of(context)!.login,
                    ),
                  ),
                  CustomRowAuth(
                    text1: AppLocalizations.of(context)!.dont_havea_ccount,
                    text2: AppLocalizations.of(context)!.create_one,
                    onTap: () {

                      Navigator.of(context).pushNamed(AppRoute.registerScreen);
                    },
                  ),
                  DividerOrWidget(),

                  CustomElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: width * 0.02,
                      children: [
                        Brand(
                          Brands.google,
                          colorFilter: ColorFilter.mode(
                            AppColor.darkGreyColor,
                            BlendMode.srcIn,
                          ),
                          size: 30,
                        ),
                        CustomTextElevatedButton(
                          text: AppLocalizations.of(context)!.login_with_google,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  Column(
                    children: [
                      CustomAnimatedSwitch(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (_formKey.currentState?.validate() == true) {
      //todo:login
      Navigator.of(context).pushNamed(AppRoute.homeScreen);
    }
  }
}
