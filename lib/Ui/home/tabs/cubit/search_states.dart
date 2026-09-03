import '../../../../api/model/movies/movies_response.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final MoviesResponse response;

  SearchSuccessState({required this.response});
}

class SearchErrorState extends SearchStates {
  final String errorMessage;

  SearchErrorState({required this.errorMessage});
}
