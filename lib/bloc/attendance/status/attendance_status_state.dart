import 'package:resturant/models/attendance/attendance_status_model.dart';

abstract class AttendanceStatusState {}

class AttendanceStatusInitial extends AttendanceStatusState {}

class AttendanceStatusLoading extends AttendanceStatusState {}

class AttendanceStatusLoaded extends AttendanceStatusState {
  final AttendanceStatusGetModel? attendanceStatus;

  AttendanceStatusLoaded({required this.attendanceStatus});
}


class AttendanceStatusError extends AttendanceStatusState {
  final String message;

  AttendanceStatusError({required this.message});
}
