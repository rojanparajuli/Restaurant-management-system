import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/bloc/side_menu/side_menu_bloc.dart';
import 'package:resturant/components/colors.dart';
// import 'package:resturant/screen/attendance/attendance_screen.dart';
import 'package:resturant/screen/employee/add_user_view.dart';
import 'package:resturant/screen/auth/change_password_view.dart';
import 'package:resturant/screen/auth/login_view.dart';
import 'package:resturant/screen/contact/contact_create_screen.dart';
import 'package:resturant/screen/contact/contact_list_view.dart';
import 'package:resturant/screen/dashboard/dashboard_view.dart';
import 'package:resturant/screen/employee/users_list_view.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

        return Scaffold(
          appBar: isMobile
              ? AppBar(
                  backgroundColor: AppColor.primaryColor,
                  title: const Text('Side Menu'),
                )
              : null,
          drawer: isMobile
              ? Drawer(
                  child: MenuContent(
                    isCollapsed: true,
                  ),
                )
              : null,
          body: Row(
            children: [
              if (!isMobile)
                Container(
                  width: isTablet ? 200 : 250,
                  color: AppColor.primaryColor,
                  child: MenuContent(
                    isCollapsed: false,
                  ),
                ),
              Expanded(
                child: BlocBuilder<SideMenuCubit, int>(
                  builder: (context, selectedIndex) {
                    final List<Widget> pages = [
                      const DashBoard(),
                      const UserListScreen(),
                      ChangePasswordScreen(),
                      CreateContactScreen(),
                      ContactListView(),
                      AddUserView(),
                      // AttendanceListScreen(),
                    ];

                    return pages[selectedIndex];
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuContent extends StatelessWidget {
  final bool isCollapsed;

  const MenuContent({super.key, required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        MenuItem(
          icon: Icons.dashboard,
          title: 'Dashboard',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<SideMenuCubit>().selectMenuItem(0);
          },
        ),
        MenuItem(
          icon: Icons.list,
          title: 'Employee List',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<SideMenuCubit>().selectMenuItem(1);
          },
        ),
        MenuItem(
          icon: Icons.lock,
          title: 'Change Password',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<SideMenuCubit>().selectMenuItem(2);
          },
        ),
        MenuItem(
          icon: Icons.person_add,
          title: 'Create Contact',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<SideMenuCubit>().selectMenuItem(3);
          },
        ),
        MenuItem(
          icon: Icons.contact_phone_rounded,
          title: 'Contact List',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<SideMenuCubit>().selectMenuItem(4);
          },
        ),
        MenuItem(
          icon: Icons.person_add,
          title: 'Add Employee',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<SideMenuCubit>().selectMenuItem(5);
          },
        ),
        // MenuItem(
        //   icon: Icons.calendar_month,
        //   title: 'Attendance',
        //   isCollapsed: isCollapsed,
        //   onTap: () {
        //     context.read<SideMenuCubit>().selectMenuItem(6);
        //   },
        // ),
        const Divider(),
        MenuItem(
          icon: Icons.logout,
          title: 'Logout',
          isCollapsed: isCollapsed,
          onTap: () {
            context.read<AuthBloc>().logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: isCollapsed ? null : Text(title),
        onTap: onTap,
      ),
    );
  }
}
