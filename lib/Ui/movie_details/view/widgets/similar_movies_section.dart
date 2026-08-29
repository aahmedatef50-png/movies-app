import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movies_grid.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_style.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({super.key, required this.movies});
  final List<Movies> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.similar,
          style: AppStyle.bold24White,
        ),
        MoviesGrid(
          movies: movies,
          cols: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}