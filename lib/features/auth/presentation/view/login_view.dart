// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/core/Fingerprint/fingerprint_auth.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/reset_password_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/sign_up_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

// // Replace with your actual snackbar helper
// import '../../../../core/common/snackbar/my_snackbar.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final _formKey = GlobalKey<FormState>();

//   final _emailController = TextEditingController(text: "Binod@gmail.com");
//   final _passwordController = TextEditingController(text: 'Binod@12');
//   final _forgotPasswordController = TextEditingController();
//   final FingerprintAuth _fingerprintAuth =
//       FingerprintAuth(); // ✅ Fingerprint Instance

//   bool _isPasswordVisible = false;
//   final _gap = const SizedBox(height: 20);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.isSuccess) {
//           // ✅ Extract role from state.user
//           final int userRole =
//               state.user?.role ?? 0; // Default to 0 if role is null

//           // ✅ Navigate to HomeView on successful login
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) =>
//                   HomeView(userRole: userRole), // ✅ Pass extracted role
//             ),
//           );
//         } else if (state.errorMessage.isNotEmpty) {
//           // Handle error by showing snackbar
//           showMySnackBar(
//             context: context,
//             message: state.errorMessage,
//             color: Colors.red,
//           );
//         }

//         if (state.isOtpSent) {
//           // ✅ Show success message and navigate to ResetPasswordView
//           showMySnackBar(
//             context: context,
//             message: "OTP sent successfully. Check your email/phone.",
//             color: Colors.green,
//           );

//           Future.delayed(const Duration(milliseconds: 500), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ResetPasswordView(
//                   emailOrPhone: _forgotPasswordController.text,
//                 ),
//               ),
//             );
//           });
//         }

//         if (state.errorMessage.isNotEmpty) {
//           // Show error message
//           showMySnackBar(
//             context: context,
//             message: state.errorMessage,
//             color: Colors.red,
//           );
//         }
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.pink[50]!,
//                 Colors.white,
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Form(
//               key: _formKey,
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.school_rounded,
//                           size: 80,
//                           color: Colors.pink[800],
//                         ),
//                         const SizedBox(height: 14),
//                         Text(
//                           'Welcome Back',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.pink[800],
//                             fontFamily: 'Brand Bold',
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Sign in to continue',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                         _buildTextField(
//                           controller: _emailController,
//                           label: 'Email',
//                           icon: Icons.person_outline,
//                         ),
//                         _gap,
//                         _buildTextField(
//                           controller: _passwordController,
//                           label: 'Password',
//                           icon: Icons.lock_outline,
//                           isObscure: !_isPasswordVisible,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.pink[800],
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () => _showForgotPasswordModal(),
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(
//                                 color: Colors.pink[800],
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),

//                         /// 🔹 **Fingerprint Authentication Button**
//                         ElevatedButton.icon(
//                           onPressed: _handleFingerprintLogin,
//                           icon: const Icon(Icons.fingerprint, size: 24),
//                           label: const Text("Login with Fingerprint"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueGrey[800],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             minimumSize: const Size(double.infinity, 50),
//                             elevation: 2,
//                           ),
//                         ),

//                         const SizedBox(height: 12),

//                         /// 🔹 **Normal Login Button**
//                         ElevatedButton(
//                           onPressed: () {
//                             // if (_emailController.text == 'Sam11@gmail.com' &&
//                             //     _passwordController.text == 'Sam@123') {
//                             if (_formKey.currentState!.validate()) {
//                               context.read<LoginBloc>().add(
//                                     LoginUserEvent(
//                                       email: _emailController.text,
//                                       password: _passwordController.text,
//                                       context: context,
//                                     ),
//                                   );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.pink[800],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             minimumSize: const Size(double.infinity, 50),
//                             elevation: 2,
//                           ),
//                           child: const Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontFamily: 'Brand Bold',
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have an account? ",
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const SignUpView()),
//                                 );
//                               },
//                               child: Text(
//                                 'Register',
//                                 style: TextStyle(
//                                   color: Colors.pink[800],
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// ✅ **Handle Fingerprint Authentication**
//   void _handleFingerprintLogin() async {
//     bool isAuthenticated = await _fingerprintAuth.authenticate();

//     if (isAuthenticated) {
//       context
//           .read<LoginBloc>()
//           .add(FingerprintLoginEvent(context: context)); // Trigger BLoC event
//     } else {
//       showMySnackBar(
//         context: context,
//         message: "Fingerprint authentication passed!",
//         color: Colors.green,
//       );
//     }
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isObscure = false,
//     Widget? suffixIcon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscure,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.pink[800]),
//         suffixIcon: suffixIcon,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//     );
//   }

//   void _showForgotPasswordModal() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildTextField(
//                 controller: _forgotPasswordController,
//                 label: "Enter email or phone",
//                 icon: Icons.email,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<LoginBloc>().add(
//                         ForgotPasswordRequested(
//                           email: _forgotPasswordController.text,
//                           context: context,
//                         ),
//                       );
//                 },
//                 child: const Text("Send OTP"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // lets start for diff role

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/core/Fingerprint/fingerprint_auth.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/forgot_password_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/reset_password_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/sign_up_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

// // Replace with your actual snackbar helper
// import '../../../../core/common/snackbar/my_snackbar.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final _formKey = GlobalKey<FormState>();

//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _forgotPasswordController = TextEditingController();
//   final FingerprintAuth _fingerprintAuth =
//       FingerprintAuth(); // ✅ Fingerprint Instance

//   bool _isPasswordVisible = false;
//   final _gap = const SizedBox(height: 20);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.isSuccess) {
//           // ✅ Navigate to HomeView on successful login
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const HomeView(
//                       userRole: 0,
//                     )),
//           );
//         }

//         if (state.isOtpSent) {
//           // ✅ Show success message and navigate to ResetPasswordView
//           showMySnackBar(
//             context: context,
//             message: "OTP sent successfully. Check your email/phone.",
//             color: Colors.green,
//           );
//           Future.delayed(const Duration(milliseconds: 500), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ResetPasswordView(
//                   emailOrPhone: _forgotPasswordController.text,
//                 ),
//               ),
//             );
//           });
//         }

//         if (state.errorMessage.isNotEmpty) {
//           // Show error message
//           showMySnackBar(
//             context: context,
//             message: state.errorMessage,
//             color: Colors.red,
//           );
//         }
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.pink[50]!,
//                 Colors.white,
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Form(
//               key: _formKey,
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.school_rounded,
//                           size: 80,
//                           color: Colors.pink[800],
//                         ),
//                         const SizedBox(height: 14),
//                         Text(
//                           'Welcome Back',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.pink[800],
//                             fontFamily: 'Brand Bold',
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Sign in to continue',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                         _buildTextField(
//                           controller: _emailController,
//                           label: 'Email',
//                           icon: Icons.person_outline,
//                         ),
//                         _gap,
//                         _buildTextField(
//                           controller: _passwordController,
//                           label: 'Password',
//                           icon: Icons.lock_outline,
//                           isObscure: !_isPasswordVisible,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.pink[800],
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const ForgotPasswordView(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(
//                                 color: Colors.pink[800],
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),

//                         /// 🔹 **Fingerprint Authentication Button**
//                         ElevatedButton.icon(
//                           onPressed: _handleFingerprintLogin,
//                           icon: const Icon(Icons.fingerprint, size: 24),
//                           label: const Text("Login with Fingerprint"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueGrey[800],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             minimumSize: const Size(double.infinity, 50),
//                             elevation: 2,
//                           ),
//                         ),

//                         const SizedBox(height: 12),

//                         /// 🔹 **Normal Login Button**
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               context.read<LoginBloc>().add(
//                                     LoginUserEvent(
//                                       context: context,
//                                       email: _emailController.text,
//                                       password: _passwordController.text,
//                                     ),
//                                   );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.pink[800],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             minimumSize: const Size(double.infinity, 50),
//                             elevation: 2,
//                           ),
//                           child: const Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontFamily: 'Brand Bold',
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have an account? ",
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const SignUpView()),
//                                 );
//                               },
//                               child: Text(
//                                 'Register',
//                                 style: TextStyle(
//                                   color: Colors.pink[800],
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// ✅ **Handle Fingerprint Authentication**
//   void _handleFingerprintLogin() async {
//     bool isAuthenticated = await _fingerprintAuth.authenticate();

//     if (isAuthenticated) {
//       context
//           .read<LoginBloc>()
//           .add(FingerprintLoginEvent(context: context)); // Trigger BLoC event
//     } else {
//       showMySnackBar(
//         context: context,
//         message: "Fingerprint authentication failed!",
//         color: Colors.red,
//       );
//     }
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isObscure = false,
//     Widget? suffixIcon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscure,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.pink[800]),
//         suffixIcon: suffixIcon,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/core/Fingerprint/fingerprint_auth.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/forgot_password_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/sign_up_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FingerprintAuth _fingerprintAuth = FingerprintAuth();

  bool _isPasswordVisible = false;
  final _gap = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // ✅ Navigate to HomeView on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(userRole: 0),
            ),
          );
        }

        if (state.errorMessage.isNotEmpty) {
          // ✅ Show error message only for login failures
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
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
                Colors.white,

                // Colors.pink[50]!,
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
                        Icon(
                          Icons.school_rounded,
                          size: 80,
                          color: Colors.pink[800],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[800],
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 40),
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.person_outline,
                        ),
                        _gap,
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isObscure: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.pink[800],
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordView(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.pink[800],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        /// 🔹 **Fingerprint Authentication Button**
                        ElevatedButton.icon(
                          onPressed: _handleFingerprintLogin,
                          icon: const Icon(Icons.fingerprint, size: 24),
                          label: const Text("Login with Fingerprint"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// 🔹 **Normal Login Button**
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    LoginUserEvent(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpView()),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.pink[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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

  /// ✅ **Handle Fingerprint Authentication**
  void _handleFingerprintLogin() async {
    bool isAuthenticated = await _fingerprintAuth.authenticate();

    if (isAuthenticated) {
      context.read<LoginBloc>().add(FingerprintLoginEvent(context: context));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fingerprint authentication failed!"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.pink[800]),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
