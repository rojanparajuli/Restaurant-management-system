import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/employee/delete/delete_user_state.dart';
import 'package:resturant/service/employee/delete_user_service.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  final DeleteUserService deleteUserService;

  DeleteUserCubit(this.deleteUserService) : super(DeleteUserStateInitial());

  Future<void> deleteUser(int id) async {
    emit(DeleteUserStateLoading());
    try {
      final response = await deleteUserService.deleteUser(id);
      if (response == 'User deleted successfully') {
        emit(DeleteUserStateSuccess(response));
      } else {
        emit(DeleteUserStateError(response));
      }
    } catch (e) {
      emit(DeleteUserStateError('An error occurred: $e'));
    }
  }
}
