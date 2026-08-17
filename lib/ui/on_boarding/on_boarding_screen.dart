import 'package:flutter/material.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../model/on_boarding_model.dart';
import '../../utils/size_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;
  late List<Onboarding> onboardingList;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      onboardingList = Onboarding.getOnBoardingList(context);
      _isInitialized = true;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final lastIndex = onboardingList.length - 1;
    final currentItem = onboardingList[currentPage];
    var width = context.width;
    var height = context.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingList.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.asset(
                      onboardingList[index].imgPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),

                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              onboardingList[index].gradientColor,
                              onboardingList[index].gradientColor,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.3, 1],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),


          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: width * .04,
                vertical: height * .025,
              ),
              decoration: BoxDecoration(
                color:
                 currentPage==0?AppColor.transparentColor:
                AppColor.blackColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                spacing: height*.015,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentItem.title,
                    textAlign: TextAlign.center,
                    style:
                   currentPage==0?AppStyle.med36White:
                    AppStyle.bold24White,
                  ),

                  if (currentItem.description != null && currentItem.description!.isNotEmpty)
                  Text(
                    currentItem.description!,
                    textAlign: TextAlign.center,
                    style:
                    currentPage==0?AppStyle.reg16Grey:
                    AppStyle.reg16White,
                  ),

                  CustomElevatedButton(
                    child: Text(
                      currentItem.primaryButtonText,
                      style: AppStyle.semi20Black,
                    ),
                    onTap: () {
                      if (currentPage == lastIndex) {
                        // todo: Navigate to Home
                        Navigator.of(context).pushNamed(AppRoute.loginScreen);
                        return;
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  // Back
                  if (currentItem.showBackButton)
                    CustomElevatedButton(
                      backgroundColor: AppColor.transparentColor,
                      sideColor: AppColor.yellowColor,
                      child: Text(
                        AppLocalizations.of(context)!.back,
                        style: AppStyle.semi20Yellow,
                      ),
                      onTap: () {
                        // if( currentPage==0){
                        //   Navigator.pop(context);
                        // }
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
