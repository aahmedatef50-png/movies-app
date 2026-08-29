import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movies_grid.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/firebase_utils.dart';

class CustomTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    var height = AppConfig.height(context);

    return TabBarView(
      children: [
        Center(
          child: StreamBuilder<QuerySnapshot<Favourite>>(
            stream: FirebaseUtils.getFavouritesCollection().snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              final docs = snapshot.data?.docs ?? [];
              final movies = docs.map((doc) {
                final fav = doc.data();
                return Movies(
                  url: fav.url,
                  id: fav.movieId,
                  rating: fav.rating,
                  largeCoverImage: fav.url
                  // include coverImage here too, per the earlier fix
                );
              }).toList();

              if (movies.isEmpty) {
                return const Text('No favourites yet');
              }
              return MoviesGrid(movies: movies);
            },
          ),
        ),
        Center(
          child: Image(
            image: AssetImage(AppImage.popCorn),
            width: width * 0.4,
            height: height * 0.16,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}