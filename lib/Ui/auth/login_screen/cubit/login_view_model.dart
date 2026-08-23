import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/auth/login_screen/cubit/login_states.dart';

class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel() : super(LoginInitialState());

  void login(
    String email,
    String password,
    BuildContext context,
    var _formKey,
  ) async {
    if (_formKey.currentState?.validate() == true) {
      try {
        emit(
          LoginLoadingState(
            loadingMessage: AppLocalizations.of(context)!.loading,
          ),
        );
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        emit(
          LoginSuccessState(
            title: AppLocalizations.of(context)!.success,
            successMessage: AppLocalizations.of(context)!.login_successfully,
          ),
        );
      } catch (e) {
        emit(
          LoginErrorState(
            title: AppLocalizations.of(context)!.error,
            errorMessage: e.toString(),
          ),
        );
        print(e.toString());
      }
    }
  }
}
