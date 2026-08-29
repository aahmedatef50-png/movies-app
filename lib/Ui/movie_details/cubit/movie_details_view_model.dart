import 'package:bloc/bloc.dart';
import 'package:my_movies_app/Ui/movie_details/cubit/movie_details_states.dart';
import 'package:my_movies_app/api/api_manger.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/api/model/movies_details/movie.dart';
import 'package:my_movies_app/api/model/movies_suggestion/movies_suggestion_mapper.dart';
class MovieDetailsViewModel extends Cubit<MovieStates> {
  MovieDetailsViewModel() : super(MovieLoadingState());
  List<Movies> similarMovies = [];

  String? errorMessage;
  Movie? movie;
  ApiManger apiManger = ApiManger();

  void getMovieDetails(int movieId) async {
    try {
      emit(MovieLoadingState());
      var movieResponse = await apiManger.getMoviesDetails(movieId: movieId);
      if (movieResponse.status == 'error') {
        errorMessage = movieResponse.statusMessage;
        emit(MovieErrorState());
        return;
      }
      if (movieResponse.status == 'ok') {
        movie = movieResponse.data!.movie;

        try {
          var suggestionResponse = await apiManger.getMoviesSuggestion(movieId);
          similarMovies =
              suggestionResponse.data?.movies?.map((m) => m.toMovies()).toList() ?? [];
        } catch (_) {
          similarMovies = [];
        }

        emit(MovieSuccessState());
      }
    } catch (e) {
      errorMessage = e.toString();
      emit(MovieErrorState());
    }
  }

}
