import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/cubit/language_cubit.dart';

import '../../utils/app_color.dart';
import '../../utils/app_config.dart';
import '../../utils/app_image.dart';

class CustomAnimatedSwitch extends StatelessWidget {
  CustomAnimatedSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, state) {
        bool isArabic = state.languageCode == 'ar';

        return AnimatedToggleSwitch.dual(
          current: isArabic,
          first: false,
          second: true,
          height: height * 0.05,
          borderWidth: 2,
          onChanged: (value) {
            context.read<LanguageCubit>().changeLanguage(value ? 'ar' : 'en');
          },
          spacing: width * 0.05,
          animationDuration: Duration(milliseconds: 400),
          iconBuilder: (value) {
            return Image.asset(
              value ? AppImage.egyptFlag : AppImage.unitedStateFlag,
              height: height * 0.043,
            );
          },
          textBuilder: (value) {
            return Image.asset(
              value ? AppImage.unitedStateFlag : AppImage.egyptFlag,
              height: height * 0.039,
            );
          },
          style: ToggleStyle(
            indicatorBorder: BoxBorder.all(
              color: AppColor.yellowColor,
              width: 3,
            ),
            borderColor: AppColor.yellowColor,
            backgroundColor: AppColor.blackColor,
          ),
        );
      },
    );
  }
}
