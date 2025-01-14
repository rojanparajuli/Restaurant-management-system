import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth_event.dart';
import 'package:resturant/bloc/auth_state.dart';
import 'package:resturant/models/auth_model.dart';
import 'package:resturant/service/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginRequested);
    on<ForgetPasswordEvent>(_onForgetPasswordRequested); 
  }

  Future<void> saveKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userKey', key);
  }

  Future<String?> getKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userKey');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userKey');
  }

  Future<bool> isLoggedIn() {
    final prefs = SharedPreferences.getInstance();
    return prefs.then((value) => value.getBool('isLoggedIn') ?? false);
  }

  Future<void> _onLoginRequested(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await authRepository.login(event.request);

      if (response?.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await saveKey(response!.token!);

        emit(AuthSuccess(response));
      } else {
        emit(AuthError('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgetPasswordRequested(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(ForgetPasswordLoading());

    try {
      final response =
          await authRepository.forgetPassword(event.request);

      if (response?.message != null) {
        emit(ForgetPasswordSuccess(ForgetPasswordResponseModel(message: response!.message)));
      } else {
        emit(ForgetPasswordError('Failed to send password reset link'));
      }
    } catch (e) {
      emit(ForgetPasswordError(e.toString()));
    }
  }
}


class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(false);

  void toggleVisibility() => emit(!state);
}
