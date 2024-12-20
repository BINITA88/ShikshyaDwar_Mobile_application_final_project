import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [
          // First Onboarding Screen
          OnboardingScreen(
            imageAsset: 'assets/images/sign.png',
            title: 'Welcome to ShikshyaDwar',
            description:
                'The one-stop platform for booking classes like IELTS, PTE, SAT, and more.',
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
          // Second Onboarding Screen with a different style
          const SecondOnboardingScreen(),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  final VoidCallback onNext;

  const OnboardingScreen({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            height: 300.0,
            width: 300.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              backgroundColor: const Color.fromARGB(255, 23, 104, 176),
              minimumSize: const Size(150, 50), // Fix button size
            ),
            onPressed: onNext,
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/hee.png', // Change image for the second screen
            height: 350.0,
            width: 450.0,
            fit: BoxFit.contain,
          ),
          const Text(
            'Start Your Learning Journey',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 13, 13, 14),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Start your learning journey with us and gain access to personalized study materials and expert guidance.',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 25.0),
                  backgroundColor: const Color.fromARGB(255, 23, 104, 176),
                  minimumSize: const Size(150, 50), // Fix button size
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 25.0),
                  backgroundColor: const Color.fromARGB(255, 23, 104, 176),
                  minimumSize: const Size(150, 50), // Fix button size
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
