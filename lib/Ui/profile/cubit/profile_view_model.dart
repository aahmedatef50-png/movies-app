import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_movies_app/model/my_user.dart';
import 'package:my_movies_app/ui/profile/cubit/profile_states.dart';

import '../../../cubit/image_index_cubit.dart';
import '../../../cubit/my_user_cubit.dart';
import '../../../utils/firebase_utils.dart';

class ProfileViewModel extends Cubit<ProfileStates> {
  ProfileViewModel() : super(ProfileInitialState());

  void updateProfile(
    BuildContext context,
    MyUser myUser,
    String name,
    String phoneNumber,
  ) async {
    MyUser newUser = MyUser(
      name: name,
      email: myUser.email,
      id: myUser.id,
      imageIndex: context.read<ImageIndexCubit>().state,
      phoneNumber: phoneNumber,
    );
    await FirebaseUtils.updateUser(newUser);
    context.read<MyUserCubit>().changeUser(newUser);
    emit(ProfileUpdateState());
  }

  Future<void> deleteAccount({String? password}) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final provider = user.providerData.first.providerId;

      if (provider == 'password') {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password ?? '',
        );

        await user.reauthenticateWithCredential(credential);

        await FirebaseUtils.deleteUser(user.uid);
        await user.delete();

        emit(ProfileDeleteAccountWithEmailAndPasswordState());
      } else if (provider == 'google.com') {
        final googleSignIn = GoogleSignIn(
          serverClientId:
              '721783966481-d6nrj5k0799g9qes83kav10o3rh84mj3.apps.googleusercontent.com',
        );

        final googleUser = await googleSignIn.signIn();

        if (googleUser == null) return;

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await user.reauthenticateWithCredential(credential);

        await FirebaseUtils.deleteUser(user.uid);
        await user.delete();

        emit(ProfileDeleteAccountWithGoogleState());
      }
    } catch (e) {
      emit(ProfileErrorState(errorMessage: e.toString()));
    }
  }
}
