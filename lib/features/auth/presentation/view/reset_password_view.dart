import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';

class ResetPasswordView extends StatefulWidget {
  final String emailOrPhone; // ✅ Passed from ForgotPassword

  const ResetPasswordView({super.key, required this.emailOrPhone});

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isPasswordReset) {
          showMySnackBar(
            context: context,
            message: "Password reset successful! Please log in.",
            color: Colors.green,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false, // ✅ Clear navigation stack
          );
        }
        if (state.errorMessage.isNotEmpty) {
          showMySnackBar(
            context: context,
            message: state.errorMessage,
            color: Colors.red,
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.pink[50]!,
                Colors.white,

                Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                        const Icon(Icons.lock_reset_rounded,
                            size: 80, color: Color.fromARGB(255, 196, 103, 28)),
                        const SizedBox(height: 14),
                        Text(
                          'Reset Your Password',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 12, 12, 12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter OTP and set a new password',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 40),
                        _buildTextField(
                          controller: _otpController,
                          label: 'Enter OTP',
                          icon: Icons.security,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _newPasswordController,
                          label: 'New Password',
                          icon: Icons.lock,
                          isObscure: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 15, 14, 15),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isObscure: true,
                        ),
                        const SizedBox(height: 24),
                        _buildResetPasswordButton(),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          child: Text(
                            'Back to Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[800],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ *Reset Password Logic*
  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        showMySnackBar(
          context: context,
          message: "Passwords do not match!",
          color: Colors.red,
        );
        return;
      }
      context.read<LoginBloc>().add(
            ResetPasswordRequested(
              emailOrPhone: widget.emailOrPhone,
              otp: _otpController.text,
              newPassword: _newPasswordController.text,
              context: context,
            ),
          );
    }
  }

  /// ✅ *Reusable TextField Widget*
  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  //   required IconData icon,
  //   bool isObscure = false,
  //   Widget? suffixIcon,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     obscureText: isObscure,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: const Color.fromARGB(255, 44, 42, 43)!),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(
  //             color: const Color.fromARGB(255, 59, 57, 58)!, width: 2),
  //       ),
  //       filled: true,
  //       fillColor: Colors.white,
  //       labelText: label,
  //       prefixIcon: Icon(icon, color: const Color.fromARGB(255, 20, 20, 20)),
  //       suffixIcon: suffixIcon,
  //       labelStyle: TextStyle(color: Colors.grey[600]),
  //     ),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter $label';
  //       }
  //       return null;
  //     },
  //   );
  // }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    Widget? suffixIcon,
    Color prefixIconColor = Colors.black, // Default color for prefix icon
    Color suffixIconColor = Colors.black, // Default color for suffix icon
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color.fromARGB(255, 81, 77, 79)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 59, 57, 58), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon:
            Icon(icon, color: prefixIconColor), // Custom prefix icon color
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(
                    color: suffixIconColor), // Custom suffix icon color
                child: suffixIcon,
              )
            : null,
        labelStyle: TextStyle(color: Colors.grey[600]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  /// ✅ *Reset Password Button*
  Widget _buildResetPasswordButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isLoading
              ? null
              : () {
                  _resetPassword();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[800],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            elevation: 2,
          ),
          child: state.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Reset Password',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
        );
      },
    );
  }
}
