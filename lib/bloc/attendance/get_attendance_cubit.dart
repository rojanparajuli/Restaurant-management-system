import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/get_attendance_state.dart';
import 'package:resturant/models/attendance/attendance_list_model.dart';
import 'package:resturant/service/attendance/get_attendance_service.dart';

class GetAttendanceCubit extends Cubit<GetAttendanceState> {
  final GetAttendanceService service;

  GetAttendanceCubit(this.service) : super(GetAttendanceInitial());

  Future<void> getAttendance() async {
    emit(GetAttendanceLoading());
    try {
      final response = await service.getAttendance();

      if (response is List<AttendanceListModel>) {
        emit(GetAttendanceLoaded(attendance: response));
      } else if (response is String) {
        emit(GetAttendanceError(message: response));
      } else {
        emit(GetAttendanceError(message: 'Unexpected response format.'));
      }
    } catch (e) {
      emit(GetAttendanceError(message: 'An error occurred: $e'));
    }
  }
}
