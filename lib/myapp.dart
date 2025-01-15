import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/bloc/change_password/change_password_bloc.dart';
import 'package:resturant/bloc/users/users_bloc.dart';
import 'package:resturant/bloc/users/users_event.dart';
import 'package:resturant/screen/dashboard_view.dart';
import 'package:resturant/screen/login_view.dart';
import 'package:resturant/service/auth_repository.dart';
import 'package:resturant/service/change_password_service.dart';
import 'package:resturant/service/users_list_service.dart';

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
          return DashBoard();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
