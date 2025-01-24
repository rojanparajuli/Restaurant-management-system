import 'package:resturant/models/attendance/attendance_list_model.dart';

abstract class GetAttendanceState {}

class GetAttendanceInitial extends GetAttendanceState {}

class GetAttendanceLoading extends GetAttendanceState {}

class GetAttendanceLoaded extends GetAttendanceState {
  final List<AttendanceListModel> attendance;

  GetAttendanceLoaded({required this.attendance});
}

class GetAttendanceError extends GetAttendanceState {
  final String message;

  GetAttendanceError({required this.message});
}
