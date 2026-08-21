import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_image.dart';

import '../../../utils/app_config.dart';

class CustomTabBarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    var height = AppConfig.height(context);
    return TabBarView(

      children: [
        Center(child: Image(image: AssetImage(AppImage.popCorn),
          width: width * 0.4,
          height: height * 0.16,
          fit: BoxFit.fill,
        )),
        Center(child: Image(image: AssetImage(AppImage.popCorn),
          width: width * 0.4,
          height: height * 0.16,
          fit: BoxFit.fill,)),
    ],
    );
  }
}
