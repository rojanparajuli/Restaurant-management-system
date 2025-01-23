import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/bloc/auth/auth_state.dart';
import 'package:resturant/bloc/auth/auth_event.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/models/auth/auth_model.dart';
import 'package:resturant/screen/auth/forget_password_view.dart';
import 'package:resturant/utilities/circle.dart';
import 'package:resturant/components/side_menu.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordVisibilityCubit = context.read<PasswordVisibilityCubit>();

    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundCircles(context),
          Column(
            children: [
              SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset('assets/icons/Business.png')),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Form(
                        key: formKey, 
                        child: Column(
                          children: [
                            TextFormField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person) ,
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your username'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<PasswordVisibilityCubit, bool>(
                              builder: (context, isVisible) {
                                return TextFormField(
                                  controller: passwordController,
                                  obscureText: !isVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed:
                                          passwordVisibilityCubit.toggleVisibility,
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter your password'
                                      : null,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SideMenu()),
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(AppColor.primaryColor),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      LoginRequestModel(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                      ),
                                    ),
                                  );
                                } 
                              },
                              child: const Text('Login',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen()),
                          );
                        },
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
