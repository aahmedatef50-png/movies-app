import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/model/my_user.dart';

class MyUserCubit extends Cubit<MyUser> {
  MyUserCubit()
    : super(
        MyUser(name: '', email: '', id: '', imageIndex: 0, phoneNumber: ''),
      );

  void changeUser(MyUser myUser) {
    emit(myUser);
  }
}
