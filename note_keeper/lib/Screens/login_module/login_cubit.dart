import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_keeper/local_database/local_database.dart';
import 'package:note_keeper/utils/shared_data.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool isVisible = false;

  ///Toggle Visibility for Password
  ///
  void toggleVisibility() {
    isVisible = !isVisible;
    emit(VisibleToggle());
  }

  ///Login Using Email & Pass & Save isLogin Value For State Persists
  Future<void> login(String username, String password) async {
    try {
      final isLogin = await NoteDatabase.instance.loginUser(username, password);
      if (isLogin) {
        emit(LoginSuccess());
        await SharedData.instance.setBool('isLoggedIn', true);
      } else {
        emit(LoginError());
      }
      print('isLogin $isLogin');
    } catch (e) {
      emit(LoginError());
    }
  }
}
