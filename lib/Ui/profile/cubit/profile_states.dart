abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileUpdateState extends ProfileStates {}

class ProfileDeleteAccountWithEmailAndPasswordState extends ProfileStates {}

class ProfileDeleteAccountWithGoogleState extends ProfileStates {}

class ProfileErrorState extends ProfileStates {
  String errorMessage;

  ProfileErrorState({required this.errorMessage});
}
