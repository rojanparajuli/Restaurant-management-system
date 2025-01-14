import 'package:resturant/models/auth_model.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginRequestModel request;
  LoginEvent(this.request);
}

class ForgetPasswordEvent extends AuthEvent {
  final ForgetPasswordRequestModel request;
  ForgetPasswordEvent(this.request);
}