import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movies_grid.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/utils/app_image.dart';

import '../../../utils/app_config.dart';

class CustomTabBarView extends StatelessWidget {
  List<Movies> movies=[
    Movies(url: "https://yts.gg/assets/images/movies/batman_knightfall_part_1_2026/large-cover.jpg",id: 1,rating: 4.4),
    Movies(url: "https://yts.gg/assets/images/movies/batman_knightfall_part_1_2026/large-cover.jpg",id: 1,rating: 4.4),
    Movies(url: "https://yts.gg/assets/images/movies/batman_knightfall_part_1_2026/large-cover.jpg",id: 1,rating: 4.4),
    Movies(url: "https://yts.gg/assets/images/movies/this_is_the_zodiac_speaking_2008/large-cover.jpg",id: 1,rating: 6.3),
    Movies(url: "https://yts.gg/assets/images/movies/this_is_the_zodiac_speaking_2008/large-cover.jpg",id: 1,rating: 6.3),
    Movies(url: "https://yts.gg/assets/images/movies/this_is_the_zodiac_speaking_2008/large-cover.jpg",id: 1,rating: 6.3),
    Movies(url: "https://yts.gg/assets/images/movies/this_is_the_zodiac_speaking_2008/large-cover.jpg",id: 1,rating: 6.3),
    Movies(url: "https://yts.gg/assets/images/movies/this_is_the_zodiac_speaking_2008/large-cover.jpg",id: 1,rating: 6.3),
  ];
  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    var height = AppConfig.height(context);
    return TabBarView(

      children: [
        Center(child:
        MoviesGrid(movies: movies,)
        ),
        Center(child: Image(image: AssetImage(AppImage.popCorn),
          width: width * 0.4,
          height: height * 0.16,
          fit: BoxFit.fill,)),
    ],
    );
  }
}
