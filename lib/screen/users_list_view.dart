import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/api/api.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/bloc/users/list/users_bloc.dart';
import 'package:resturant/bloc/users/list/users_event.dart';
import 'package:resturant/bloc/users/list/users_state.dart';
import 'package:resturant/screen/user_detail_view.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the screen is initialized
    context.read<UserListBloc>().add(FetchUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
               Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/icons/Business.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    context.read<UserListBloc>().add(UserSearchEvent(value));
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<UserListBloc, UserListState>(
                  builder: (context, state) {
                    if (state is UserListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserListLoaded) {
                      if (state.users.isEmpty) {
                        return const Center(child: Text('No data found'));
                      } else {
                        return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return Card(
                              color: Colors.transparent,
                              child: ListTile(
                                leading: user.image != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${Api.mediaUrl}${user.image!}"),
                                      )
                                    : const CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                title: Row(
                                  children: [
                                    Text("ID: ${user.id ?? 'Unknown'}"),
                                    SizedBox(width: 16),
                                    Text("Username: ${user.username ?? 'Unknown'}"),
                                  ],
                                ),
                                subtitle: Text("Email: ${user.email ?? 'No Email'}"),
                                trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserDetailScreen(user: user),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Detail',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is UserListError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('No data found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
