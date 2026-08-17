import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormFeild extends StatelessWidget {
  CustomTextFormFeild({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onValidator,
    this.obscure = false,
    this.textInputType,
  });

  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  OnValidator? onValidator;
  TextEditingController? controller;
  bool obscure;
  TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      cursorColor: AppColor.whiteColor,
      style: AppStyle.reg16White,
      controller: controller,
      validator: onValidator,
      obscureText: obscure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.reg16White,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: AppColor.darkGreyColor,
        filled: true,
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(),
        errorBorder: _outlineInputBorder(borderSideColor: AppColor.redColor),
        focusedErrorBorder: _outlineInputBorder(
          borderSideColor: AppColor.redColor,
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder({Color? borderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: borderSideColor ?? AppColor.darkGreyColor),
    );
  }
}