import 'package:flutter_bloc/flutter_bloc.dart';

class GenreIndexCubit extends Cubit<int> {
  GenreIndexCubit() : super(0);

  void increment() {
    int next = state == 12 ? 0 : state + 1;
    emit(next);
  }

  void resetIndex() {
    emit(0);
  }

  void changeIndex(int index) {
    emit(index);
  }
}
