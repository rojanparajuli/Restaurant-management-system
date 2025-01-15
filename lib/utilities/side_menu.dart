import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/screen/change_password_view.dart';
import 'package:resturant/screen/login_view.dart';
import 'package:resturant/screen/users_list_view.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  void _logout(BuildContext context) {
    context.read<AuthBloc>().logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.red.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ListTile(
              leading: const Icon(Icons.person_add, color: Colors.red),
              title: const Text('Add Employee'),
              onTap: () {}),
          ListTile(
            leading: const Icon(Icons.list, color: Colors.red),
            title: const Text('Employee List'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserListScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.red),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
