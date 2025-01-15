import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/users/users_event.dart';
import 'package:resturant/bloc/users/users_state.dart';
import 'package:resturant/service/users_list_service.dart';

class UserListBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserListBloc(this.userService) : super(UserInitial()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userService.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError('Failed to fetch user data'));
      }
    });
  }
}
