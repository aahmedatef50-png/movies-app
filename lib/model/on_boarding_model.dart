import 'package:flutter/material.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_image.dart';

class Onboarding {
  final String imgPath;
  final String title;
  final String? description;
  final bool showBackButton;
  final String primaryButtonText;
  final Color gradientColor;

  Onboarding({
    required this.imgPath,
    required this.title,
    this.description,
    this.showBackButton = true,
    required this.primaryButtonText,
    required this.gradientColor,
  });

  static List<Onboarding> getOnBoardingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      Onboarding(
        imgPath: AppImage.moviesPoster,
        title: l10n.intro_title,
        description: l10n.intro_body,
        showBackButton: false,
        primaryButtonText: l10n.explore_now,
        gradientColor: AppColor.blackColor,
      ),
      Onboarding(
        imgPath: AppImage.onboarding1,
        title: l10n.onboarding1_title,
        description: l10n.onboarding1_body,
        primaryButtonText: l10n.next,
        gradientColor: AppColor.onBoarding1Color,
      ),
      Onboarding(
        imgPath: AppImage.onboarding2,
        title: l10n.onboarding2_title,
        description: l10n.onboarding2_body,
        primaryButtonText: l10n.next,
        gradientColor:AppColor.onBoarding2Color,
      ),
      Onboarding(
        imgPath: AppImage.onboarding3,
        title: l10n.onboarding3_title,
        description: l10n.onboarding3_body,
        primaryButtonText: l10n.next,
        gradientColor: AppColor.onBoarding3Color,
      ),
      Onboarding(
        imgPath: AppImage.onboarding4,
        title: l10n.onboarding4_title,
        description: l10n.onboarding4_body,
        primaryButtonText: l10n.next,
        gradientColor:AppColor.onBoarding4Color,
      ),
      Onboarding(
        imgPath: AppImage.onboarding5,
        title: l10n.onboarding5_title,
        primaryButtonText: l10n.finish,
        gradientColor: AppColor.onBoarding5Color,
      ),
    ];
  }
}
