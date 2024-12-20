import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void _login(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == 'samjhana@gmail.com' && password == 'samjhana123') {
      // Regular user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1), // Show message for 2 seconds
        ),
      );

      // Delay navigation to give time for snack bar to appear
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else if (email == 'binita@gmail.com' && password == 'binita123') {
      // Admin user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Admin Login Successful!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1), // Show message for 2 seconds
        ),
      );

      // Delay navigation to give time for snack bar to appear
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    } else {
      // Invalid credentials
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1), // Show message for 2 seconds
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 12.0),
                      backgroundColor: const Color.fromARGB(255, 23, 104, 176),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Google authentication coming soon!'),
                                backgroundColor: Colors.blue,
                              ),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Facebook authentication coming soon!'),
                                backgroundColor:
                                    Color.fromARGB(255, 44, 190, 95),
                                duration: Duration(seconds: 6),
                              ),
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
