import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/home/tabs/cubit/movie_states.dart';
import 'package:my_movies_app/api/api_manger.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';

class MovieViewModel extends Cubit<MovieStates>{
  MovieViewModel():super(MovieLoadingState());

  List<Movies>? moviesList;

  void getMovies()async{
    try{
      // todo : loading
      emit(MovieLoadingState());
      // todo : call Api
      var response = await ApiManger().getMovies();
      if(response.status == 'error'){
        // todo : error
        emit(MovieErrorState(errorMessage: response.statusMessage!));
      }else if(response.status == 'ok'){
        // todo : success
        moviesList = response.data?.movies??[];
        emit(MovieSuccessState());
      }
    }catch(e){
      emit(MovieErrorState(errorMessage: e.toString()));
    }
  }


}