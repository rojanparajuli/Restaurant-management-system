import 'package:resturant/models/attendance/checkin_checkout/checkin/check_in_out_model.dart';

abstract class CheckInEvent {}

class CheckInRequested extends CheckInEvent {
  final CheckInRequestModel request;

  CheckInRequested(this.request);
}

class FetchCheckInDetails extends CheckInEvent {
  final int userId;

  FetchCheckInDetails(this.userId);
}