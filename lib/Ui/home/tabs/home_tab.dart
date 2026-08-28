import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_states.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_view_model.dart';
import 'package:my_movies_app/Ui/widget/main_error_widget.dart';
import 'package:my_movies_app/Ui/widget/main_loading_widget.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movie_card.dart';
import 'package:my_movies_app/api/api_manger.dart';
import 'package:my_movies_app/api/model/movies/movies_response.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/size_utils.dart';

import '../../../api/model/movies/movies.dart';


class HomeTab extends StatefulWidget {

   HomeTab({super.key,});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  MovieViewModel viewModel = MovieViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovies();
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
                            items: moviesList!.map((movie) {

                              return Builder(
                                builder: (BuildContext context) {
                                  return MovieCard(movie: movie);
                                },
                              );
                            }).toList(),
                          ),
                          Image.asset(AppImage.watchNow),
                         Row(
                           children: [
                            Text(moviesList[currentIndex.value].genres?.first??'',style: AppStyle.bold20White,),
                             Spacer(),
                             TextButton(onPressed: (){},
                                 child: Row(
                                   spacing:width*0.01,
                                   children: [
                                     Text(AppLocalizations.of(context)!.see_more,style: AppStyle.reg16Yellow,),
                                     Icon(Icons.arrow_forward,color: AppColor.yellowColor,)
                                   ],
                                 )),
                           ],
                         ),


                          SizedBox(
                            height: height*0.25,
                            child:ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(width: width*0.04,);
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount:moviesList.length,
                              itemBuilder: (context, index) {
                                return MovieCard(movie: moviesList[index]);
                              },),
                          )

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
