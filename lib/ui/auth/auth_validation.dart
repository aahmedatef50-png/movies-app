import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';

class AuthValidation {
  static String? nameValidator(String? text, BuildContext context) {
    if (text == null || text.trim().isEmpty) {
      return AppLocalizations.of(context)!.please_enter_name;
    }
    return null;
  }

  static String? emailValidator(String? text, BuildContext context) {
    if (text == null || text.trim().isEmpty) {
      return AppLocalizations.of(context)!.please_enter_email;
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      return AppLocalizations.of(context)!.please_enter_valid_Email;
    }
    return null;
  }

  static String? passwordValidator(String? text, BuildContext context) {
    if (text == null || text.trim().isEmpty) {
      return AppLocalizations.of(context)!.please_enter_password;
    }
    if (text.length < 6) {
      return AppLocalizations.of(context)!.password_should_be_at_least_6_chars;
    }
    return null;
  }

  static String? rePasswordValidator(
    String? text,
    BuildContext context,
    TextEditingController passwordController,
  ) {
    if (text == null || text.trim().isEmpty) {
      return AppLocalizations.of(context)!.please_enter_confirm_password;
    }
    if (text != passwordController.text) {
      return AppLocalizations.of(context)!.repassword_doesnt_math_password;
    }
    return null;
  }

  static String? phoneValidator(String? text, BuildContext context) {
    if (text == null || text.trim().isEmpty) {
      return AppLocalizations.of(context)!.please_enter_phone;
    }
    if (text.length != 11) {
      return AppLocalizations.of(context)!.please_enter_correct_phone_number;
    }
    return null;
  }
}
