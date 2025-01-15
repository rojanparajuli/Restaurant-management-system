import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/users/users_event.dart';
import 'package:resturant/bloc/users/users_state.dart';
import 'package:resturant/service/users_list_service.dart';

class UserListBloc extends Bloc<UserEvent, UserListState> {
  final UserService userService;

  UserListBloc(this.userService) : super(UserListInitial()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        final users = await userService.fetchUsers();
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserListError('Failed to fetch user data'));
      }
    });
  }
}
