import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/users/users_bloc.dart';
import 'package:resturant/bloc/users/users_event.dart';
import 'package:resturant/bloc/users/users_state.dart';
import 'package:resturant/service/users_list_service.dart';


class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: BlocProvider(
        create: (context) => UserListBloc(UserService())..add(FetchUsersEvent()),
        child: BlocBuilder<UserListBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: user.image != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.image!),
                          )
                        : CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user.username ?? 'No Username'),
                    subtitle: Text(user.email ?? 'No Email'),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ),
      ),
    );
  }
}
