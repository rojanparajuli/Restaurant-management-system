import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/status/attendance_status_state.dart';
import 'package:resturant/service/attendance/attendance_status_service.dart';

class AttendanceStatusCubit extends Cubit <AttendanceStatusState>{
  final AttendanceStatusService _attendanceStatusService;

  AttendanceStatusCubit(this._attendanceStatusService) : super(AttendanceStatusInitial());

  Future<void> getAttendanceStatus() async {
    emit(AttendanceStatusLoading());
    try {
      final response = await _attendanceStatusService.getAttendanceStatus();

      // if (response is List<dynamic>) {
      //   final attendanceStatus = response.map((item) => AttendanceStatusGetModel.fromJson(item)).toList();
      //   
      // } else if (response is String) {
      //   emit(AttendanceStatusError(message: response));
      // } else {
      //   emit(AttendanceStatusError(message: 'Unexpected response format.'));
      // }
      emit(AttendanceStatusLoaded(attendanceStatus: response));
    } catch (e) {
      emit(AttendanceStatusError(message: 'An error occurred: $e'));
    }
  }

}