import 'package:flutter/cupertino.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movie_card.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({
    super.key,
    required this.movies,
    this.cols = 3,
    this.shrinkWrap = false,
    this.physics,
  });
  final List<Movies> movies;
  final int cols;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => MovieCard(movie: movies[index]),
      itemCount: movies.length,
    );
  }
}