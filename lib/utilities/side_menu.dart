import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/side_menu/side_menu_bloc.dart';
import 'package:resturant/screen/change_password_view.dart';
import 'package:resturant/screen/dashboard_view.dart';
import 'package:resturant/screen/users_list_view.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.red.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.dashboard, color: Colors.red),
                  title: const Text('Dashboard'),
                  onTap: () {
                    context.read<SideMenuCubit>().selectMenuItem(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list, color: Colors.red),
                  title: const Text('Employee List'),
                  onTap: () {
                    context.read<SideMenuCubit>().selectMenuItem(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.red),
                  title: const Text('Change Password'),
                  onTap: () {
                    context.read<SideMenuCubit>().selectMenuItem(2);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout logic
                  },
                ),
              ],
            ),
          ),
              Expanded(
            child: BlocBuilder<SideMenuCubit, int>(
              builder: (context, selectedIndex) {
                final List<Widget> pages = [
                  const DashBoard(),
                  const UserListScreen(),
                  ChangePasswordScreen(),
                ];
    
                return pages[selectedIndex];
              },
            ),
          ),
        ],
      ),
    );
  }
}
