import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/api/api.dart';
import 'package:resturant/api/colors.dart';
import 'package:resturant/bloc/users/users_bloc.dart';
import 'package:resturant/bloc/users/users_state.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No data found'));
            } else {
              return Stack(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16,),
                      SizedBox(height: 16,),
                      SizedBox(
                        height: 60,
                        width: 500,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                          // onChanged: (value) {
                          //   context
                          //       .read<UserListBloc>()
                          //       .add(UserSearchEvent(value));
                          // },
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return Card(
                              color: Colors.transparent,
                              child: ListTile(
                                leading: user.image != null
                                    ? Container(
                                        width:
                                            50, 
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withAlpha(
                                                  (0.1 * 255).toInt()), 
                                              blurRadius: 6,
                                              offset: Offset(
                                                  0, 3), 
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: ClipOval(
                                            child: Image.network(
                                              "${Api.mediaUrl}${user.image!}",
                                              fit: BoxFit
                                                  .cover, 
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Icon(
                                                Icons.person,
                                                color: Colors
                                                    .grey, 
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[
                                              300],
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors
                                              .grey, 
                                        ),
                                      ),
                                title: Text("Username: ${user.username ?? 'Unknown'}"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Email: ${user.email ?? 'No Email'}"),
                                    Text("Phone: ${user.phoneNumber ?? 'No Phone'}"),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: ElevatedButton(
                                    style:  ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                    
                                    
                                    onPressed: (){}, child: Text('Detail' , style: TextStyle(color: Colors.white),)),
                                ),
                                
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          } else if (state is UserListError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
