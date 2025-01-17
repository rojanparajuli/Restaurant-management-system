import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/users/choose_image/image_choose_cubit.dart';
import 'package:resturant/bloc/users/choose_image/image_choose_state.dart';
import 'package:resturant/bloc/users/edit/users_edit_event.dart';
import 'package:resturant/bloc/users/edit/users_edit_state.dart';
import 'package:resturant/service/users_list_service.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserEditService userEditService;
  final ImageChooseCubit imageChooseCubit = ImageChooseCubit();


  EditUserBloc(this.userEditService) : super(EditUserInitial()) {
    on<EditUserSubmitEvent>((event, emit) async {
      emit(EditUserLoading());
      try {
        final response = await userEditService.updateUser(event.updatedUser);
        if (response.statusCode == 200) {
          emit(EditUserSuccess('User updated successfully'));
        } else {
          emit(EditUserError('Failed to update user'));
        }
      } catch (e) {
        emit(EditUserError(e.toString()));
      }
    }
    );
    on <UploadImageEvent>((event, emit) async {
      imageChooseCubit.chooseProfilePicture();
      emit(EditUserLoading());
      try {
        await userEditService.uploadProfilePicture(event.userId, event.image);
        
          emit(EditUserSuccess('User updated successfully'));
       
      } catch (e) {
        emit(EditUserError(e.toString()));
      }
    });
  }



   
}
