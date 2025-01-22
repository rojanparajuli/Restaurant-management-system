import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/bloc/auth/change_password/change_password_bloc.dart';
import 'package:resturant/bloc/auth/change_password/change_password_event.dart';
import 'package:resturant/bloc/auth/change_password/change_password_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> oldPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> newPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier(false);

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Password should be at least 6 characters with a mix of letters, numbers and symbols plus Capital letter',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildPasswordField(
                              controller: oldPasswordController,
                              label: 'Old Password',
                              obscureNotifier: oldPasswordVisible,
                            ),
                            SizedBox(height: 16),
                            _buildPasswordField(
                              controller: newPasswordController,
                              label: 'New Password',
                              obscureNotifier: newPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'New password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            _buildPasswordField(
                              controller: confirmPasswordController,
                              label: 'Confirm New Password',
                              obscureNotifier: confirmPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm password is required';
                                }
                                if (value != newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: 50,
                              width: 800,
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
                                onPressed: state is ChangePasswordLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<ChangePasswordBloc>().add(
                                                ChangePasswordSubmitted(
                                                  oldPassword: oldPasswordController.text,
                                                  newPassword:
                                                      newPasswordController.text,
                                                ),
                                              );
                                        }
                                      },
                                child: state is ChangePasswordLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Change Password' , style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required ValueNotifier<bool> obscureNotifier,
    String? Function(String?)? validator,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, obscureText, child) {
        return SizedBox(
          width: 800,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  obscureNotifier.value = !obscureNotifier.value;
                },
              ),
            ),
            obscureText: obscureText,
            validator: validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  return null;
                },
          ),
        );
      },
    );
  }
}
