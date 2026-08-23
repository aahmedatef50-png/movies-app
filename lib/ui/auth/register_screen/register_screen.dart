import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/auth/register_screen/avatar_slider.dart';
import 'package:my_movies_app/ui/auth/register_screen/cubit/register_states.dart';
import 'package:my_movies_app/ui/auth/register_screen/cubit/register_view_model.dart';
import 'package:my_movies_app/ui/auth/register_screen/register_text_feild.dart';
import 'package:my_movies_app/ui/widget/custom_animated_switch.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/ui/widget/custom_row_auth.dart';
import 'package:my_movies_app/ui/widget/custom_text_elevated_button.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/utils_dialog.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedAvatar = '';
  final _formKey = GlobalKey<FormState>();
  bool switchWidget = false;
  bool obscure = true;
  bool obscureRePass = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();


  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);

    return BlocConsumer<RegisterViewModel, RegisterStates>(
      bloc: viewModel,
      buildWhen: (previous, current) {
        return current is RegisterInitialState;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.register,
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
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: height * 0.02,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: height * 0.15,
                      child: AvatarSlider(selectedAvatar: selectedAvatar),
                    ),
                    Text(
                      AppLocalizations.of(context)!.avatar,
                      style: AppStyle.reg16White,
                      textAlign: TextAlign.center,
                    ),
                    RegisterTextFeild(
                      phoneController: phoneController,
                      repasswordController: repasswordController,
                      passwordController: passwordController,
                      emailController: emailController,
                      nameController: nameController,
                      obsure: obscure,
                      obsureRepass: obscureRePass,
                      obscureRePassText: () {
                        if (obscureRePass) {
                          obscureRePass = false;
                        } else {
                          obscureRePass = true;
                        }
                        setState(() {});
                      },
                      obscureText: () {
                        if (obscure) {
                          obscure = false;
                        } else {
                          obscure = true;
                        }
                        setState(() {});
                      },
                    ),
                    CustomElevatedButton(
                      onTap: () {
                        return viewModel.register(
                            passwordController.text, emailController.text,
                            context, _formKey);
                      },
                      child: CustomTextElevatedButton(
                        text: AppLocalizations.of(context)!.create_account,
                      ),
                    ),
                    CustomRowAuth(
                      text1: AppLocalizations.of(
                        context,
                      )!.already_havea_account,
                      text2: AppLocalizations.of(context)!.login,
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoute.loginScreen);
                      },
                    ),
                    Column(children: [CustomAnimatedSwitch()]),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          UtilsDialog.showLoading(
            context: context,
            content: state.loadingMessage,
          );
        } else if (state is RegisterErrorState) {
          UtilsDialog.hideDialog(context: context);
          UtilsDialog.showMessage(
            context: context,
            posAction: AppLocalizations.of(context)!.ok,
            content: state.errorMessage,
            title: state.title,
          );
        } else if (state is RegisterSuccessState) {
          UtilsDialog.hideDialog(context: context);
          UtilsDialog.showMessage(
            context: context,
            content: state.successMessage,
            posActions: () {
              Navigator.pushNamed(context, AppRoute.homeScreen);
            },
            posAction: AppLocalizations.of(context)!.ok,
            title: state.title,
          );
        }
      },
    );

  }


}
