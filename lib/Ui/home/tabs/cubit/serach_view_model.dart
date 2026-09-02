import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api_manger.dart';
import 'search_states.dart';

class SearchViewModel extends Cubit<SearchStates> {
  SearchViewModel(this.apiManager) : super(SearchInitialState());

  final ApiManger apiManager;

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());

    try {
      final response = await apiManager.getMovies(queryTerm: query.trim());

      if (response.status == 'ok') {
        emit(SearchSuccessState(response: response));
      } else {
        emit(
          SearchErrorState(
            errorMessage: response.statusMessage ?? 'Something went wrong',
          ),
        );
      }
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }

  void resetSearch() {
    emit(SearchInitialState());
  }
}
