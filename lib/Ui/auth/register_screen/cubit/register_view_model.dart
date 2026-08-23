import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/auth/register_screen/cubit/register_states.dart';

class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterViewModel() : super(RegisterInitialState());

  void register(String password, String email, BuildContext context,
      var _formKey) async {
    if (_formKey.currentState?.validate() == true) {
      try {
        emit(
          RegisterLoadingState(
            loadingMessage: AppLocalizations.of(context)!.loading,
          ),
        );
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        emit(
          RegisterSuccessState(
            successMessage: AppLocalizations.of(context)!.register_successfully,
            title: AppLocalizations.of(context)!.success,
          ),
        );
      } catch (e) {
        emit(
          RegisterErrorState(
            errorMessage: e.toString(),
            title: AppLocalizations.of(context)!.error,
          ),
        );
      }
    }
  }
}
