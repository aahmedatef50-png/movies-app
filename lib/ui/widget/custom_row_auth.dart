import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_style.dart';

class CustomRowAuth extends StatelessWidget {
  CustomRowAuth({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  String text1;
  String text2;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1, style: AppStyle.reg14White),
        GestureDetector(
          onTap: onTap,
          child: Text(text2, style: AppStyle.bold14Yellow),
        ),
      ],
    );
  }
}
