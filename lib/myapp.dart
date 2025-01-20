import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/bloc/auth/change_password/change_password_bloc.dart';
import 'package:resturant/bloc/contact/create/contact_create_bloc.dart';
import 'package:resturant/bloc/contact/list/contact_list_bloc.dart';
import 'package:resturant/bloc/side_menu/side_menu_bloc.dart';
import 'package:resturant/bloc/employee/choose_image/image_choose_cubit.dart';
import 'package:resturant/bloc/employee/edit/users_edit_bloc.dart';
import 'package:resturant/bloc/employee/list/users_bloc.dart';
import 'package:resturant/bloc/employee/list/users_event.dart';
import 'package:resturant/screen/auth/login_view.dart';
import 'package:resturant/service/auth/auth_repository.dart';
import 'package:resturant/service/auth/change_password_service.dart';
import 'package:resturant/service/contact/contact_list_service.dart';
import 'package:resturant/service/contact/create_contact_service.dart';
import 'package:resturant/service/employee/users_list_service.dart';
import 'package:resturant/components/side_menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepository: AuthService())),
        BlocProvider(
          create: (_) => PasswordVisibilityCubit(),
        ),
        BlocProvider(
          create: (_) => ChangePasswordBloc(
            service: ChangePasswordService(),
          ),
        ),
        BlocProvider(
          create: (context) => UserListBloc(UserService())..add(FetchUsersEvent()),
        ),
        BlocProvider(
      create: (context) => SideMenuCubit(),),
      BlocProvider(
        create: (context) => EditUserBloc(UserEditService())),
        BlocProvider(
        create: (context) => ImageChooseCubit()),
        BlocProvider(
        create: (context) => ContactBloc(ContactService())),
        BlocProvider(create: (context)=> ContactListBloc(ContactListService()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const OnBoardingScreen(),
      ),
    );
  }
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: context.read<AuthBloc>().isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!) {
          return SideMenu();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
