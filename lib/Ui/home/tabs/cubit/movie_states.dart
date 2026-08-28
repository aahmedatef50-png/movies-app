import 'package:my_movies_app/api/model/movies/movies.dart';

import '../../../../api/model/movies_details/movie.dart';

class MovieStates {}

class MovieLoadingState extends MovieStates{}
class MovieErrorState extends MovieStates{
  String errorMessage;
  MovieErrorState({required this.errorMessage});
}
class MovieSuccessState extends MovieStates{

  MovieSuccessState();
}
