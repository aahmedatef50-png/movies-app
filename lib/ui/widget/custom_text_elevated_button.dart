import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_style.dart';

class CustomTextElevatedButton extends StatelessWidget {
  CustomTextElevatedButton({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppStyle.reg20Black);
  }
}
