// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/onboarding_cubit.dart';

// class OnboardingPage extends StatefulWidget {
//   final LoginBloc loginBloc;

//   const OnboardingPage({super.key, required this.loginBloc});

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         children: [
//           OnboardingScreen(
//             imageAsset: 'assets/images/sign.png',
//
//             onNext: () {
//               _pageController.nextPage(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeIn,
//               );
//             },
//           ),
//           SecondOnboardingScreen(

//               onTap: () {
//                 context.read<DashboardCubit>().openStudentView(context);
//               },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OnboardingScreen extends StatelessWidget {
//   final String imageAsset;
//   final String title;
//   final String description;
//   final VoidCallback onNext;

//   const OnboardingScreen({
//     super.key,
//     required this.imageAsset,
//     required this.title,
//     required this.description,
//     required this.onNext,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imageAsset,
//             height: 300,
//             width: 300,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             description,
//             style: const TextStyle(fontSize: 18, color: Colors.black54),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton(
//             onPressed: onNext,
//             child: const Text('Next'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SecondOnboardingScreen extends StatelessWidget {
//   final VoidCallback onProceed;

//   const SecondOnboardingScreen({super.key, required this.onProceed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/hee.png',
//             height: 350,
//             width: 450,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Start Your Learning Journey',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Gain access to personalized study materials and expert guidance.',
//             style: TextStyle(fontSize: 16, color: Colors.black54),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton(
//             onPressed: (){

//                 context.read<OnboardingCubit>().open(context);

//             },
//             child: const Text('Get Started'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/onboarding_cubit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    // Perform initialization logic if needed.
    // Remove the emit(context) call as it's not appropriate here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 249, 250, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/sign.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to ShikshyaDwar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'The one-stop platform for booking classes like IELTS, PTE, SAT, and more.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<OnboardingCubit>().openLoginView(context);
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
