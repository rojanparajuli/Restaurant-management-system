import 'package:resturant/models/user_list_model.dart';

abstract class EditUserState  {
  
  List<Object?> get props => [];
}

class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserSuccess extends EditUserState {
  final UsersList updatedUser;

  EditUserSuccess(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class EditUserError extends EditUserState {
  final String message;

  EditUserError(this.message);

  @override
  List<Object?> get props => [message];
}
