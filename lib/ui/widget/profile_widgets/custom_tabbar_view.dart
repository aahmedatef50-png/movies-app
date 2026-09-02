import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movies_grid.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/model/watch_history.dart';
import 'package:my_movies_app/cubit/my_user_cubit.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/firebase_utils.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({super.key});

  Widget emptyView(BuildContext context) {
    var width = AppConfig.width(context);
    var height = AppConfig.height(context);

    return Center(
      child: Image(
        image: AssetImage(AppImage.popCorn),
        width: width * 0.4,
        height: height * 0.16,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<MyUserCubit>().state;

    return TabBarView(
      children: [
        StreamBuilder<List<Favourite>>(
          stream: FirebaseUtils.getFavorites(user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }

            final favourites = snapshot.data ?? [];

            if (favourites.isEmpty) {
              return emptyView(context);
            }

            final movies = favourites.map((fav) {
              return Movies(
                id: fav.movieId,
                rating: fav.rating,
                largeCoverImage: fav.largeCoverImage,
              );
            }).toList();

            return MoviesGrid(movies: movies);
          },
        ),

        StreamBuilder<List<WatchHistory>>(
          stream: FirebaseUtils.getWatchHistory(user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              print("HISTORY ERROR: ${snapshot.error}");

              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            final history = snapshot.data ?? [];

            if (history.isEmpty) {
              return emptyView(context);
            }

            final movies = history.map((movie) {
              return Movies(
                id: movie.movieId,
                rating: movie.rating,
                largeCoverImage: movie.largeCoverImage,
              );
            }).toList();

            return MoviesGrid(movies: movies);
          },
        ),
      ],
    );
  }
}