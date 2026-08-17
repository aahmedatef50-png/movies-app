import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_style.dart';

class CustomCountlabel extends StatelessWidget {
  CustomCountlabel({required this.label,required this.count});
  String label;
  int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Text(count.toString(),
          style: AppStyle.bold36White,),
        Text(label,
          style: AppStyle.bold24White,)
      ],
    );
  }
}
