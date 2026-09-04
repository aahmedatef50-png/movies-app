import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/movie_details/cubit/movie_details_states.dart';
import 'package:my_movies_app/Ui/movie_details/cubit/movie_details_view_model.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/cast_section.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/genres_section.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/movie_state_section.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/screenshots_section.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/similar_movies_section.dart';
import 'package:my_movies_app/Ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/Ui/widget/custom_error_widget.dart';
import 'package:my_movies_app/Ui/widget/custom_loading_widget.dart';
import 'package:my_movies_app/cubit/my_user_cubit.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/model/watch_history.dart';
import 'package:my_movies_app/ui/movie_details/view/widgets/movie_poster_section.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/firebase_utils.dart';
import 'package:my_movies_app/utils/size_utils.dart';

import '../../../utils/app_color.dart';
import 'widgets/movie_webview.dart';
class MovieDetailsScreen extends StatefulWidget {
  // Movie movie;
  // MovieDetailsScreen({required this.movie});
  final num? movieId;

  const MovieDetailsScreen({
    super.key,
     this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();
  @override
  void initState() {
    super.initState();

    viewModel.getMovieDetails(widget.movieId!.toInt());
    // viewModel.getMovieDetails(widget.movie.id!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    return Scaffold(
      body: BlocBuilder<MovieDetailsViewModel, MovieStates>(
        bloc: viewModel,
        builder: (context, MovieStates state) {
          if (state is MovieSuccessState) {
            final movie = viewModel.movie!;
            final user = context.read<MyUserCubit>().state;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MoviePosterSection(movie: movie, userId: user.id),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .04),
                      child: Column(
                        spacing: height * .02,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomElevatedButton(
                            backgroundColor: AppColor.redColor,
                            child: Text(
                              AppLocalizations.of(context)!.watch,
                              style: AppStyle.bold24White,
                            ),
                            onTap: () async {
                              final user = context.read<MyUserCubit>().state;

                              final history = WatchHistory(
                                movieId: movie.id!,
                                rating: movie.rating!,
                                largeCoverImage: movie.largeCoverImage!,
                                userId: user.id,
                              );

                              await FirebaseUtils.addToWatchHistory(history);

                              if (!context.mounted) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieWebview(
                                    movie: movie,
                                  ),
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MovieStateSection(
                                icon: AppImage.favoriteIcon,
                                text: "${movie.likeCount}",
                              ),
                              MovieStateSection(
                                icon: AppImage.watchIcon,
                                text: "${movie.runtime}",
                              ),
                              MovieStateSection(
                                icon: AppImage.starIcon,
                                text: "${movie.rating}",
                              ),
                            ],
                          ),
                          ScreenshotsSection(movie: movie),
                          SimilarMoviesSection(movies: viewModel.similarMovies),
                          Text(
                            AppLocalizations.of(context)!.summary,
                            style: AppStyle.bold24White,
                          ),
                          Text(
                            movie.descriptionFull!,
                            style: AppStyle.reg16White,
                          ),
                          CastSection(movie: movie),
                          GenresSection(movie: movie),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MovieErrorState) {
            return Center(
              child: CustomErrorWidget(
                text: viewModel.errorMessage!,
                onClick: () {
                  viewModel.getMovieDetails(widget.movieId!.toInt());
                  // viewModel.getMovieDetails(widget.movie.id!.toInt());
                },
              ),
            );
          } else {
            return CustomLoadingWidget();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }
}
