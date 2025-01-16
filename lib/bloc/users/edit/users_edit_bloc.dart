import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/users/edit/users_edit_event.dart';
import 'package:resturant/bloc/users/edit/users_edit_state.dart';
import 'package:resturant/service/users_list_service.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserEditService userEditService;

  EditUserBloc(this.userEditService) : super(EditUserInitial()) {
    on<EditUserSubmitEvent>((event, emit) async {
      emit(EditUserLoading());
      try {
        final response = await userEditService.updateUser(event.updatedUser);
        if (response.statusCode == 200) {
          emit(EditUserSuccess(event.updatedUser));
        } else {
          emit(EditUserError('Failed to update user'));
        }
      } catch (e) {
        emit(EditUserError(e.toString()));
      }
    });
  }
}
