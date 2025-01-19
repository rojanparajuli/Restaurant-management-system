import 'package:resturant/models/employee/user_list_model.dart';

abstract class UserListState   {
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UsersList> users;

  UserListLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UserListError extends UserListState {
  final String message;

  UserListError(this.message);

  @override
  List<Object?> get props => [message];
}
