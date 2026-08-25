import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movies_grid.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/firebase_osama_test.dart';

import '../../../utils/app_config.dart';

class CustomTabBarView extends StatefulWidget {
  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  List<Movies> movies=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFaviorates();
  }
  void getAllFaviorates()async {
   var querySnapShot= await FirebaseOsamaTest.getFavouritesCollection().get();
   movies=querySnapShot.docs.map((doc){
    return Movies(url: doc.data().url,id: doc.data().movieId,rating: doc.data().rating);
   }).toList();
setState(() {

});
  }

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
