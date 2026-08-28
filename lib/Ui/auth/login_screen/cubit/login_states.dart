import 'package:flutter/cupertino.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {
  String loadingMessage;

  LoginLoadingState({required this.loadingMessage});
}

class LoginSuccessState extends LoginStates {
  String successMessage;
  String title;

  LoginSuccessState({required this.title, required this.successMessage});
}

class LoginErrorState extends LoginStates {
  String errorMessage;
  String title;

  LoginErrorState({required this.title, required this.errorMessage});
}
