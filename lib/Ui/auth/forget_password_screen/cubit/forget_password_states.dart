abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {
  String loadingMessage;

  ForgetPasswordLoadingState({required this.loadingMessage});
}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  String errorMessage;
  String title;

  ForgetPasswordErrorState({required this.title, required this.errorMessage});
}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  String successMessage;
  String title;

  ForgetPasswordSuccessState({
    required this.title,
    required this.successMessage,
  });
}
