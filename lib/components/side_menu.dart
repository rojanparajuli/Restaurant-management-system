import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/bloc/auth/auth_state.dart';
import 'package:resturant/bloc/side_menu/side_menu_bloc.dart';
import 'package:resturant/screen/auth/change_password_view.dart';
import 'package:resturant/screen/contact/contact_create_screen.dart';
import 'package:resturant/screen/dashboard/dashboard_view.dart';
import 'package:resturant/screen/auth/login_view.dart';
import 'package:resturant/screen/employee/users_list_view.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/screen/add_user_view.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: context.read<AuthBloc>(),
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Row(
          children: [
            Container(
              width: 250,
              color: AppColor.primaryColor,
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
                  ListTile(
                    leading: const Icon(Icons.person_add, color: Colors.red),
                    title: const Text('Create Contact'),
                    onTap: () {
                      context.read<SideMenuCubit>().selectMenuItem(3);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout'),
                    onTap: () {
                      context.read<AuthBloc>().logout();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));

             
             
            
                Expanded(
              child: BlocBuilder<SideMenuCubit, int>(
                builder: (context, selectedIndex) {
                  final List<Widget> pages = [
                    const DashBoard(),
                    const UserListScreen(),
                    ChangePasswordScreen(),
                    CreateContactScreen(),
                    AddUserView(),
                  ];
            
                  return pages[selectedIndex];
                },
              ),
            );
                    },
                  ),
          ]
        ),
      ),
          ],
        )
      )
    );
  }
}
