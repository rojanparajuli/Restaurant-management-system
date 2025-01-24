import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/list/get_attendance_state.dart';
import 'package:resturant/service/attendance/get_attendance_service.dart';

class GetAttendanceCubit extends Cubit<GetAttendanceState> {
  final GetAttendanceService service;

  GetAttendanceCubit(this.service) : super(GetAttendanceInitial());

  Future<void> getAttendance() async {
    emit(GetAttendanceLoading());
    try {
      final response = await service.getAttendance();
      emit(GetAttendanceLoaded(attendance: response != null ? [response] : []));
    } catch (e) {
      emit(GetAttendanceError(message: 'An error occurred: $e'));
    }
  }
}
