import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/widget/text_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _gap = const SizedBox(height: 16);
  final _key = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image container
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                        height: MediaQuery.of(context).size.height * 0.3,
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
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return Text(
                                  'Create a new account',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  _gap,
                                  CustomTextField(
                                    controller: _usernameController,
                                    label: 'Username',
                                    icon: Icons.person,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter username'
                                            : null,
                                  ),
                                  _gap,
                                  CustomTextField(
                                    controller: _emailController,
                                    label: 'Email',
                                    icon: Icons.email,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter email'
                                            : null,
                                  ),
                                  _gap,
                                  CustomTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    icon: Icons.lock,
                                    obscureText: true,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter password'
                                            : null,
                                  ),
                                  const SizedBox(height: 25),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_key.currentState!.validate()) {
                                          showMySnackBar(
                                            context: context,
                                            message: 'Registration Successful!',
                                            color: Colors.green,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account? ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // context.read<RegisterBloc>().add(
                                            //       NavigateHomeScreenEvent(
                                            //         destination: LoginView(),
                                            //         context: context,
                                            //       )
                                            //     );
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.pink[800],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
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
}
