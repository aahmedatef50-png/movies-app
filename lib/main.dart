import 'package:flutter/material.dart';
import 'package:my_movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:my_movies_app/ui/on_boarding/on_boarding_screen.dart';
import 'package:my_movies_app/utils/app_route.dart';

import 'package:my_movies_app/utils/app_theme.dart';

import 'l10n/app_localizations.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      initialRoute:AppRoute.onBoardingScreen ,
      routes: {
        AppRoute.onBoardingScreen:(context)=> OnboardingScreen(),
        AppRoute.loginScreen:(context)=> LoginScreen(),

      },

    );
  }
}
