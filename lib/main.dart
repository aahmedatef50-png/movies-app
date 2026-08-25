import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/home/home_screen.dart';
import 'package:my_movies_app/ui/auth/forget_password_screen/forget_password_screen.dart';
import 'package:my_movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:my_movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:my_movies_app/ui/my_bloc_observer.dart';
import 'package:my_movies_app/ui/on_boarding/on_boarding_screen.dart';
import 'package:my_movies_app/ui/profile/update_profile.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_theme.dart';

import 'l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
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
        AppRoute.editProfileScreen:(context)=>UpdateProfile(),
        AppRoute.homeScreen:(context)=>HomeScreen(),
        AppRoute.forgetPasswordScreen:(context)=>ForgetPasswordScreen(),
        AppRoute.registerScreen:(context)=>RegisterScreen()
      },

    );
  }
}
