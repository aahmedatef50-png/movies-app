import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';

class AppTheme {
  static ThemeData darkTheme=ThemeData(
      appBarTheme: AppBarThemeData(
        backgroundColor: AppColor.blackColor,
      ),
     scaffoldBackgroundColor: AppColor.blackColor,
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
       backgroundColor: AppColor.darkGreyColor,
       unselectedItemColor: AppColor.whiteColor,
       selectedItemColor: AppColor.yellowColor
     )
  );
}