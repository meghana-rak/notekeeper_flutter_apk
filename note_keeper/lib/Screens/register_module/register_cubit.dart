import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_keeper/local_database/local_database.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool isVisible = false;

  ///Toggle for Password Visibility
  void toggleVisibility() {
    isVisible = !isVisible;
    emit(PassVisibleToggle());
  }

  ///register user with email and pass & store in database
  Future<void> register(String username, String password) async {
    try {
      final result =
          await NoteDatabase.instance.registerUser(username, password);
      if (result != -1) {
        ///if register successful then state change to RegisterSuccess
        emit(RegisterSuccess());
      } else {
        ///else error state
        emit(RegisterError());
      }
    } catch (e) {
      emit(DataError());
    }
  }
}
