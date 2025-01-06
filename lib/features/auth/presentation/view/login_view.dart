import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/register_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == 'samjhana@gmail.com' && password == 'samjhana123') {
      showMySnackBar(
        context: context,
        message: 'Login Successful!',
        color: Colors.green,
      );

      Future.delayed(const Duration(seconds: 2), () {
        context.read<LoginBloc>().add(
              NavigateHomeScreenEvent(
                destination: HomeView(),
                context: context,
              ),
            );
      });
    } else if (email == 'binita@gmail.com' && password == 'binita123') {
      showMySnackBar(
        context: context,
        message: 'Admin Login Successful!',
        color: Colors.green,
      );

      Future.delayed(const Duration(seconds: 2), () {
        context.read<LoginBloc>().add(
              NavigateHomeScreenEvent(
                destination: HomeView(),
                context: context,
              ),
            );
      });
    } else {
      showMySnackBar(
        context: context,
        message: 'Invalid email or password',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image container limited to top portion
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height:
                  MediaQuery.of(context).size.height * 0.4, // Limit to top 40%
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sig.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.25, // Adjust logo section height
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.school,
                                size: 50, // Slightly reduced icon size
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 28, // Slightly reduced font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return Text(
                                  'Sign in to continue learning',
                                  style: TextStyle(
                                    fontSize: 20, // Slightly reduced font size
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter email'
                                          : null,
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter password'
                                          : null,
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _login(context);
                                      }
                                      // context.read<LoginBloc>().add(
                                      //       LoginStudentEvent(
                                      //         email: _usernameController.text,
                                      //         password: _passwordController.text,
                                      //       ),
                                      //     );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 3,
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                        child:
                                            Divider(color: Colors.grey[700])),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        'OR',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Expanded(
                                        child:
                                            Divider(color: Colors.grey[700])),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _socialButton(
                                        context: context,
                                        image: 'assets/images/google.png',
                                        text: 'Google',
                                        message:
                                            'Google authentication coming soon!',
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: _socialButton(
                                        context: context,
                                        image: 'assets/images/facebook.png',
                                        text: 'Facebook',
                                        message:
                                            'Facebook authentication coming soon!',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account? ",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<LoginBloc>().add(
                                                NavigateRegisterScreenEvent(
                                                  destination: RegisterView(),
                                                  context: context,
                                                ),
                                              );
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.blue[800],
                                            fontWeight: FontWeight.bold,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton({
    required BuildContext context,
    required String image,
    required String text,
    required String message,
  }) {
    return ElevatedButton(
      onPressed: () {
        showMySnackBar(
          context: context,
          message: message,
          color: Colors.blue,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
