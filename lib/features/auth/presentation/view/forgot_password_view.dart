import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/reset_password_view.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isOtpSent) {
          showMySnackBar(
            context: context,
            message: "OTP sent successfully. Check your email/phone.",
            color: Colors.green,
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordView(
                  emailOrPhone: _emailOrPhoneController.text,
                ),
              ),
            );
          });
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800],
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Subtitle
                  Text(
                    "Enter your registered email or phone number to receive an OTP.",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 24, 21, 21),
                    ),
                  ),

                  // Image Section
                  Center(
                    child: Image.asset(
                      'assets/images/login.png',
                      height: 280, // Reduced height
                      width: 450, // Reduced width
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Email/Phone Input
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailOrPhoneController,
                          decoration: InputDecoration(
                            labelText: "Email or Phone",
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 10, 9)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 66, 62, 62)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: const Color.fromARGB(255, 61, 58, 58)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 74, 73, 74),
                                  width: 1),
                            ),
                            prefixIcon: Icon(Icons.email,
                                color: const Color.fromARGB(255, 13, 14, 14)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email or phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Send OTP Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    ForgotPasswordRequested(
                                      email: _emailOrPhoneController.text,
                                      context: context,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Send OTP",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/reset_password_view.dart';
// import '../../../../core/common/snackbar/my_snackbar.dart';

// class ForgotPasswordView extends StatefulWidget {
//   const ForgotPasswordView({super.key});

//   @override
//   State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
// }

// class _ForgotPasswordViewState extends State<ForgotPasswordView> {
//   final TextEditingController _emailOrPhoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.isOtpSent) {
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
//                   emailOrPhone: _emailOrPhoneController.text,
//                 ),
//               ),
//             );
//           });
//         }

//         if (state.errorMessage.isNotEmpty) {
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
//                 Colors.pink[50]!,
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Back Button
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10, bottom: 5),
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                             size: 28),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                     Text(
//                       "Forgot Password",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[800],
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     // Subtitle
//                     Text(
//                       "Enter your registered email or phone number to receive an OTP.",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: const Color.fromARGB(255, 24, 21, 21),
//                       ),
//                     ),

//                     // Image Section
//                     Center(
//                       child: Image.asset(
//                         'assets/images/login.png',
//                         height: 280, // Reduced height
//                         width: 450, // Reduced width
//                         fit: BoxFit.contain,
//                       ),
//                     ),

//                     // Email/Phone Input
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           TextFormField(
//                             controller: _emailOrPhoneController,
//                             decoration: InputDecoration(
//                               labelText: "Email or Phone",
//                               labelStyle: TextStyle(
//                                   color: const Color.fromARGB(255, 12, 10, 9)),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(
//                                     color: const Color.fromARGB(
//                                         255, 103, 98, 100)),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide:
//                                     BorderSide(color: Colors.grey.shade300),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(
//                                     color:
//                                         const Color.fromARGB(255, 89, 85, 87),
//                                     width: 2),
//                               ),
//                               prefixIcon: Icon(Icons.email,
//                                   color:
//                                       const Color.fromARGB(255, 10, 109, 112)),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email or phone';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 20),

//                           // Send OTP Button
//                           ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<LoginBloc>().add(
//                                       ForgotPasswordRequested(
//                                         email: _emailOrPhoneController.text,
//                                         context: context,
//                                       ),
//                                     );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.pink[800],
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             child: const Text(
//                               "Send OTP",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailOrPhoneController.dispose();
//     super.dispose();
//   }
// }
