import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';


class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColor.yellowColor));
  }
}