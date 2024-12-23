import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void _login(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == 'samjhana@gmail.com' && password == 'samjhana123') {
      // Regular user
      showMySnackbar(
        context: context,
        message: 'Login Successful!',
        color: Colors.green,
      );

      // Delay navigation to give time for snack bar to appear
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else if (email == 'binita@gmail.com' && password == 'binita123') {
      // Admin user
      showMySnackbar(
        context: context,
        message: 'Admin Login Successful!',
        color: Colors.green,
      );

      // Delay navigation to give time for snack bar to appear
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    } else {
      // Invalid credentials
      showMySnackbar(
        context: context,
        message: 'Invalid email or password',
        color: Colors.red,
      );
    }
  }

// login page
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        'please login to your ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        'account',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    children: [
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 38.0),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(5, 45),
                      backgroundColor: Color.fromARGB(255, 12, 51, 82),
                    ),
                    onPressed: () => _login(context),
                    child: const Text(
                      'Login',
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
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                width: 0.5, color: Colors.grey),
                          ),
                          onPressed: () {
                            showMySnackbar(
                              context: context,
                              message: 'Google authentication coming soon!',
                              color: Colors.blue,
                            );
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
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                width: 0.5, color: Colors.grey),
                          ),
                          onPressed: () {
                            showMySnackbar(
                              context: context,
                              message: 'Facebook authentication coming soon!',
                              color: Color.fromARGB(255, 44, 190, 95),
                            );
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
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        ' Do not have an account?',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          ' SignUp',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: const Color.fromARGB(255, 23, 104, 176),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
