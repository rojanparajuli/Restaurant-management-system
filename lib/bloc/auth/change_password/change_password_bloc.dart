import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/auth/change_password_model.dart';
import 'package:resturant/service/auth/change_password_service.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordService service;

  ChangePasswordBloc({required this.service}) : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  Future<void> _onChangePasswordSubmitted(
      ChangePasswordSubmitted event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    try {
      final response = await service.changePassword(
        ChangePasswordRequestModel(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        ),
      );

      if (response.error != null) {
        emit(ChangePasswordFailure(error: response.error!));
      } else {
        emit(ChangePasswordSuccess(message: response.message!));
      }
    } catch (e) {
      emit(ChangePasswordFailure(error: e.toString()));
    }
  }
}
