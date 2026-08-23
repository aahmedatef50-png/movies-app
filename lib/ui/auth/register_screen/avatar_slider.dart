import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/cubit/image_index_cubit.dart';

import '../../../model/app_model.dart';
import '../../../utils/app_config.dart';

class AvatarSlider extends StatelessWidget {
  AvatarSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return CarouselSlider.builder(
      itemCount: AppModel.avatars.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          GestureDetector(
            onTap: () {
              context.read<ImageIndexCubit>().changeIndex(itemIndex);
            },
            child: Image.asset(
              AppModel.avatars[itemIndex],
              height: height * 0.02,
              fit: BoxFit.fill,
              width: width * 0.35,
            ),
          ),
      options: CarouselOptions(
        enlargeCenterPage: true,
        aspectRatio: 2.3,
        viewportFraction: 0.33,
        animateToClosest: true,
        enlargeFactor: 0.5,
      ),
    );
  }
}
