import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_states.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_view_model.dart';
import 'package:my_movies_app/Ui/widget/main_error_widget.dart';
import 'package:my_movies_app/Ui/widget/main_loading_widget.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movie_card.dart';
import 'package:my_movies_app/cubit/genre_index_cubit.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/size_utils.dart';

typedef SeeMoreClick =void Function(int);
class HomeTab extends StatefulWidget {
  bool isActive;
  SeeMoreClick seeMoreClick;

  HomeTab({super.key, required this.isActive, required this.seeMoreClick});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  MovieViewModel viewModel = MovieViewModel();
  late final genreIndexCubit = context.read<GenreIndexCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovies();
  }

  @override
  void didUpdateWidget(covariant HomeTab oldWidget) {
    // TODO: implement didUpdateWidget
    if (!oldWidget.isActive && widget.isActive) {
      genreIndexCubit.increment();
    }
  }

   final ValueNotifier<int> currentIndex=ValueNotifier<int>(0);



  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return  BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MovieViewModel , MovieStates>
        (
        builder: (context, state) {
          if(state is MovieLoadingState){
            return MainLoadingWidget();
          }else if(state is MovieErrorState){
            return MainErrorWidget(errorMessage:state.errorMessage,
                onPressed: (){
              viewModel.getMovies();
                });
          }else {
            var moviesList = viewModel.moviesList;
            final List<dynamic> allGenres = moviesList
            !.expand((movie) => movie.genres ?? [])
                .toSet()
                .toList();
            final selectedGenre = allGenres[genreIndexCubit.state];

            final filterMovies = moviesList.where((movie) {
              return movie.genres?.contains(selectedGenre) ?? false;
            }).toList();
                return  SingleChildScrollView(
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.5,
                          child: ValueListenableBuilder(
                            valueListenable: currentIndex,
                            builder: (context, index, child) {
                              return Image.network(moviesList![index].largeCoverImage! ,
                                height: height*0.6 ,width: double.infinity,fit: BoxFit.fill,);
                            },

                          )),
                      Column(
                        spacing: height*0.02,
                        children: [
                          SizedBox(height: height*0.01,),
                          Image.asset(AppImage.avaliableNow),
                          CarouselSlider(
                            options: CarouselOptions(height:height*0.38,
                                viewportFraction: 0.55,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.2,
                                onPageChanged: (index,reson){

                                  currentIndex.value=index;

                                }
                            ),
                            items: moviesList.map((movie) {

                              return Builder(
                                builder: (BuildContext context) {
                                  return MovieCard(movie: movie);
                                },
                              );
                            }).toList(),
                          ),
                          Image.asset(AppImage.watchNow),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03
                            ),
                            child: BlocBuilder<GenreIndexCubit, int>(
                              bloc: genreIndexCubit,
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(allGenres[state],
                                          style: AppStyle.bold20White,),
                                        Spacer(),
                                        TextButton(onPressed: () {
                                          widget.seeMoreClick(2);
                                        },
                                            child: Row(
                                              spacing: width * 0.01,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .see_more,
                                                  style: AppStyle.reg16Yellow,),
                                                Icon(Icons.arrow_forward,
                                                  color: AppColor.yellowColor,)
                                              ],
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.02,),
                                    SizedBox(
                                      height: height * 0.25,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return SizedBox(width: width * 0.04,);
                                        },
                                        scrollDirection: Axis.horizontal,
                                        itemCount: filterMovies.length,
                                        itemBuilder: (context, index) {
                                          return MovieCard(
                                              movie: filterMovies[index]);
                                        },),
                                    ),
                                  ],
                                );
                              },

                            ),
                         ),

                          SizedBox(height: height * 0.1,)

                        ],
                      )
                    ],
                  ),
                );
                }

        },),
    );

  }
}
