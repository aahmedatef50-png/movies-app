import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_movies_app/cubit/my_user_cubit.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/model/my_user.dart';
import 'package:my_movies_app/ui/auth/login_screen/cubit/login_states.dart';
import 'package:my_movies_app/utils/firebase_utils.dart';

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
        final userSubscription = FirebaseUtils
            .getUserFromFireStore(credential.user?.uid ?? '')
            .listen((user) {
          if (user != null) {
            context.read<MyUserCubit>().changeUser(user);
          }
        });

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
      }
    }
  }

  void loginWithGoogle(BuildContext context) async {
    try {
      emit(LoginLoadingState(
          loadingMessage: AppLocalizations.of(context)!.loading));
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
        '721783966481-d6nrj5k0799g9qes83kav10o3rh84mj3.apps.googleusercontent.com',
      );

      // Trigger the authentication flow
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      MyUser myUser = MyUser(name: googleUser?.displayName ?? '',
          email: googleUser?.email ?? "",
          id: googleUser?.id ?? '',
          imageIndex: 0,
          phoneNumber: 'null');
      if (myUser.id == googleUser!.id) {
        final userSubscription = FirebaseUtils
            .getUserFromFireStore(googleUser?.id ?? '')
            .listen((user) {
          if (user != null) {
            context.read<MyUserCubit>().changeUser(user);
          }
        });
      } else {
        FirebaseUtils.addUserInFireStore(myUser);
        context.read<MyUserCubit>().changeUser(myUser);
      }


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
    }
  }
}
