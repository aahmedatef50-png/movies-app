abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {
  String loadingMessage;

  RegisterLoadingState({required this.loadingMessage});
}

class RegisterErrorState extends RegisterStates {
  String errorMessage;
  String title;

  RegisterErrorState({required this.errorMessage, required this.title});
}

class RegisterSuccessState extends RegisterStates {
  String successMessage;
  String title;

  RegisterSuccessState({required this.successMessage, required this.title});
}
