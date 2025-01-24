import 'package:resturant/models/attendance/checkin_checkout/checkin/check_in_out_model.dart';

abstract class CheckInState {}

class CheckInInitial extends CheckInState {}

class CheckInLoading extends CheckInState {}

class CheckInSuccess extends CheckInState {
  final CheckInResponseModel response;

  CheckInSuccess(this.response);
}

class CheckInFailure extends CheckInState {
  final String error;

  CheckInFailure(this.error);
}