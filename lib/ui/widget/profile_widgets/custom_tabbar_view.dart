import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_image.dart';

class CustomTabBarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabBarView(

      children: [
      Center(child: Image(image: AssetImage(AppImage.popCorn),)),
      Center(child: Image(image: AssetImage(AppImage.popCorn),)),
    ],
    );
  }
}
