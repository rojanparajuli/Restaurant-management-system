import 'package:resturant/models/auth/auth_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponseModel response;
  AuthSuccess(this.response);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class ForgetPasswordSuccess extends AuthState {
  final ForgetPasswordResponseModel response;
  ForgetPasswordSuccess(this.response);
}

class ForgetPasswordError extends AuthState {
  final String message;
  ForgetPasswordError(this.message);
}

class ForgetPasswordLoading extends AuthState {}