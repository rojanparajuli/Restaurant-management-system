import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/checkin_out/checkinout_event.dart';
import 'package:resturant/bloc/attendance/checkin_out/checkinout_state.dart';
import 'package:resturant/service/attendance/checkin/checkinout_service.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckInService service;

  CheckInBloc(this.service) : super(CheckInInitial()) {
    on<CheckInRequested>(_onCheckInRequested);
  }

  Future<void> _onCheckInRequested(
      CheckInRequested event, Emitter<CheckInState> emit) async {
    emit(CheckInLoading());
    try {
      final response = await service.checkIn(event.request);
      emit(CheckInSuccess(response));
    } catch (e) {
      emit(CheckInFailure(e.toString()));
    }
  }
}
