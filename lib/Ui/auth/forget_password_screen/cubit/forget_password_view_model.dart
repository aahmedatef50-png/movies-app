import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/auth/forget_password_screen/cubit/forget_password_states.dart';

class ForgetPasswordViewModel extends Cubit<ForgetPasswordStates> {
  ForgetPasswordViewModel() : super(ForgetPasswordInitialState());

  void resetPassword(String email, BuildContext context, var _formKey) async {
    if (_formKey.currentState?.validate() == true) {
      //todo:reset password
      try {
        emit(
          ForgetPasswordLoadingState(
            loadingMessage: AppLocalizations.of(context)!.loading,
          ),
        );
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        emit(
          ForgetPasswordSuccessState(
            title: AppLocalizations.of(context)!.success,
            successMessage: AppLocalizations.of(
              context,
            )!.please_check_your_email_to_reset_password,
          ),
        );
      } catch (e) {
        emit(
          ForgetPasswordErrorState(
            title: AppLocalizations.of(context)!.error,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
