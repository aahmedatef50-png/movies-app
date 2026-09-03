import 'package:dio/dio.dart';
import 'package:my_movies_app/api/dio_interceptors.dart';
import 'package:my_movies_app/api/end_points/end_points.dart';
import 'package:my_movies_app/api/model/movies/movies_response.dart';
import 'package:my_movies_app/api/model/movies_details/movies_details_response.dart';
import 'package:my_movies_app/api/model/movies_suggestion/movies_suggestion_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManger {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://movies-api.accel.li'));

  ApiManger() {
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  /*https://movies-api.accel.li/api/v2/list_movies.json?quality=3D*/
  Future<MoviesResponse> getMovies({String? queryTerm}) async {
    try {
      var response = await dio.get(
        EndPoints.moviesEndPoint,
        queryParameters: {
          if (queryTerm != null && queryTerm.isNotEmpty)
            'query_term': queryTerm,
        },
      );

      return MoviesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Future<MoviesResponse> getMovies() async {
  //   try {
  //     var response = await dio.get(EndPoints.moviesEndPoint, queryParameters: {
  //       'limit': 40
  //     });
  //     return MoviesResponse.fromJson(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  /*https://movies-api.accel.li/api/v2/movie_details.json?movie_id=15&with_images=true&with_cast=true*/
  Future<MoviesDetailsResponse> getMoviesDetails( {required int movieId}) async {
    try {
      var response = await dio.get(
        EndPoints.moviesDetailsEndPoint,
        queryParameters: {
          'movie_id':movieId,
          'with_images': true,
          'with_cast': true,
        },
      );
      return MoviesDetailsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  /*https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=10*/
  Future<MoviesSuggestionResponse> getMoviesSuggestion(int id) async {
    try {
      var response = await dio.get(
        EndPoints.moviesSuggestionEndPoint,
        queryParameters: {'movie_id': id},
      );
      return MoviesSuggestionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
