import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_states.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_view_model.dart';
import 'package:my_movies_app/Ui/widget/main_error_widget.dart';
import 'package:my_movies_app/Ui/widget/main_loading_widget.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movies_grid.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/cubit/genre_index_cubit.dart';
import 'package:my_movies_app/ui/home/tabs/widget/browse_tab/container_list_view_browse_tab.dart';
import 'package:my_movies_app/utils/size_utils.dart';

class BrowserTab extends StatefulWidget {

  BrowserTab({super.key});


  @override
  State<BrowserTab> createState() => _BrowserTabState();
}

class _BrowserTabState extends State<BrowserTab> {
  late int currentIndex = context
      .watch<GenreIndexCubit>()
      .state;
  MovieViewModel viewModel = MovieViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovies();
  }


  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);


    return BlocBuilder<GenreIndexCubit, int>(


      builder: (context, genreIndex) {
        return BlocBuilder<MovieViewModel, MovieStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is MovieErrorState) {
              return MainErrorWidget(
                  errorMessage: state.errorMessage,
                  onPressed: () {
                    viewModel.getMovies();
                    setState(() {

                    });
                  });
            }
            else if (state is MovieSuccessState) {
              List<Movies> moviesList = viewModel.moviesList ?? [];
              final List<dynamic> allGenres = moviesList
                  .expand((movie) => movie.genres ?? [])
                  .toSet()
                  .toList();
              final selectedGenre = allGenres[genreIndex];

              final filterMovies = moviesList.where((movie) {
                return movie.genres?.contains(selectedGenre) ?? false;
              }).toList();

              return SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<GenreIndexCubit>().changeIndex(
                                  index);
                            },
                            child: ContainerListViewBrowseTab(
                                genre: allGenres[index],
                                isSelected: genreIndex == index),
                          );
                        },
                        itemCount: allGenres.length,
                      ),
                    ),
                    Expanded(child: MoviesGrid(movies: filterMovies, cols: 2,)),
                    SizedBox(height: height * 0.08,)

                  ],
                ),
              );
            } else {
              return MainLoadingWidget();
            }
          },
        );
      },
    );
  }
}
