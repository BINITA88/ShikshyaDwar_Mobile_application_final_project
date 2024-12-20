import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 35.0), // Add top padding to move text down
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Let’s get you',
                            style: TextStyle(fontSize: 27.0),
                          ),
                          Text(
                            'on board',
                            style: TextStyle(fontSize: 27.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                            labelText: 'Full Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^\S+@\S+\.\S+$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 31.0),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(5, 45),
                        backgroundColor: Color.fromARGB(255, 12, 51, 82),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Clear form fields
                          _nameController.clear();
                          _emailController.clear();
                          _passwordController.clear();

                          // Use the showMySnackbar function
                          showMySnackbar(
                            context: context,
                            message: 'Registration Successful',
                            color: Colors.green,
                          );

                          // Delay navigation to give time for Snackbar to appear
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pushReplacementNamed(context, '/login');
                          });
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 60.0,
                            child: Divider(color: Colors.black87),
                          ),
                        ),
                        Text(
                          'Or',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 60.0,
                            child: Divider(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              // Google authentication logic.
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  fit: BoxFit.contain,
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                const Text(
                                  'Google',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              // Facebook authentication logic.
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/facebook.png',
                                  fit: BoxFit.cover,
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                const Text(
                                  'Facebook',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            ' Sign In',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 23, 104, 176),
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
        ],
      ),
    );
  }
}
