import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movie_card.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({required this.movies});
  final List<Movies> movies;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2/3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        itemBuilder: (context,index){
          final movie=movies[index];
          return MovieCard(movie: movie,);
        },
        itemCount: movies.length,
    );
  }
}
