// intro_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/size_utils.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/app_image.dart';
import '../../utils/app_style.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var height=AppConfig.height(context);
    var width=AppConfig.width(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImage.moviesPoster, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: height * .025),
              child: Column(
                spacing: height*.02,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.intro_title, style: AppStyle.med36White, textAlign: TextAlign.center),
                  Text(l10n.intro_body, style: AppStyle.reg16Grey, textAlign: TextAlign.center),
                  CustomElevatedButton(
                    child: Text(l10n.explore_now, style: AppStyle.semi20Black),
                    onTap: () => Navigator.pushNamed(context, AppRoute.onBoardingScreen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}