import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en'));

  void changeLanguage(String languageCode) {
    emit(Locale(languageCode));
  }
}
