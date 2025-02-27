import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SplashCubit>().init(context);
    });
  }

  Widget _buildLogoScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pink[50]!, // Light pink at the top
            Colors.white, // White at the bottom
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 12), // Added spacing
                  const Text(
                    'Shikshyadwar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B4EFF)),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Added Scaffold to prevent layout issues
      body: _buildLogoScreen(),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view/onboarding_page.dart';
// import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   final PageController _pageController = PageController();
//   bool _showLogoScreen = true;

//   final List<Map<String, String>> _splashData = [
//     {
//       "image": "assets/images/pexels-ivan-samkov-5676744.jpg",
//       "title": "Welcome to Shikshyadwar",
//       "description":
//           "Your gateway to quality education and study abroad counseling."
//     },
//     {
//       "image": "assets/images/onboarding12.png",
//       "title": "Book Instantly",
//       "description":
//           "Reserve your seat for IELTS, PTE, SAT, and TOEFL classes in seconds!"
//     },
//     {
//       "image": "assets/images/uni.jpg",
//       "title": "Secure Payments",
//       "description":
//           "Fast and reliable online transactions for seamless bookings."
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     context.read<SplashCubit>().updatePage(0);
//     Future.delayed(const Duration(seconds: 4), () {
//       setState(() {
//         _showLogoScreen = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _showLogoScreen
//           ? _buildLogoScreen() // Show Logo screen first
//           : _buildOnboardingScreen(), // Then show onboarding
//     );
//   }

//   Widget _buildLogoScreen() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.pink[50]!, // Light pink color at the top
//             Colors.white, // White color at the bottom
//           ],
//         ),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 200,
//                     width: 200,
//                     child: Image.asset('assets/images/logo.png'),
//                   ),
//                   const Text(
//                     'Shikshyadwar',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF333333),
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             Container(
//               padding: const EdgeInsets.all(4),
//               child: const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B4EFF)),
//                 strokeWidth: 3,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOnboardingScreen() {
//     return BlocBuilder<SplashCubit, int>(
//       builder: (context, state) {
//         return Stack(
//           children: [
//             Positioned.fill(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: _splashData.length,
//                 onPageChanged: (index) {
//                   context.read<SplashCubit>().updatePage(index);
//                 },
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.asset(
//                         _splashData[index]["image"]!,
//                         fit: BoxFit.cover,
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.transparent,
//                               Color.fromARGB(200, 19, 19, 19),
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.transparent,
//                       Color.fromARGB(170, 19, 19, 19),
//                       Color.fromARGB(200, 25, 23, 23),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       _splashData[state]["title"]!,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontFamily: 'Poppins',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       _splashData[state]["description"]!,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.white70,
//                         fontFamily: 'Poppins',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),
//                     _buildBottomControls(context, state),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildBottomControls(BuildContext context, int currentPage) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const SizedBox(width: 60), // Empty space for alignment
//         Row(
//           children: List.generate(
//             _splashData.length,
//             (index) => _buildDot(index, currentPage),
//           ),
//         ),
//         currentPage == _splashData.length - 1
//             ? GestureDetector(
//                 onTap: () {
//                   // Navigate to the main content or home page when the onboarding is finished
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           const OnboardingPage(), // Replace with your home or dashboard page
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Finish',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             : GestureDetector(
//                 onTap: () {
//                   // Move to the next page in the onboarding sequence
//                   _pageController.nextPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.ease,
//                   );
//                 },
//                 child: const Text(
//                   'Next',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _buildDot(int index, int currentPage) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4.0),
//       height: 10,
//       width: currentPage == index ? 20 : 10,
//       decoration: BoxDecoration(
//         color: currentPage == index ? Colors.blue : Colors.grey,
//         borderRadius: BorderRadius.circular(5),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_sensors/flutter_sensors.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   StreamSubscription? _subscription;
//   List<double> _lastValues = [0, 0, 0];

//   @override
//   void initState() {
//     super.initState();
//     _startShakeDetection();
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel(); // Stop shake detection when screen is disposed
//     super.dispose();
//   }

//   /// **Shake Detection Logic**
//   void _startShakeDetection() async {
//     try {
//       bool isAvailable =
//           await SensorManager().isSensorAvailable(Sensors.ACCELEROMETER);
//       if (!isAvailable) {
//         debugPrint("Accelerometer sensor not available.");
//         return;
//       }

//       // ✅ FIX: Await the Stream before listening
//       final stream = await SensorManager().sensorUpdates(
//         sensorId: Sensors.ACCELEROMETER,
//         interval: Sensors.SENSOR_DELAY_UI,
//       );

//       _subscription = stream.listen((event) {
//         double x = event.data[0];
//         double y = event.data[1];
//         double z = event.data[2];

//         double deltaX = (x - _lastValues[0]).abs();
//         double deltaY = (y - _lastValues[1]).abs();
//         double deltaZ = (z - _lastValues[2]).abs();

//         _lastValues = [x, y, z];

//         double shakeThreshold = 15.0; // Adjust threshold as needed
//         if (deltaX > shakeThreshold ||
//             deltaY > shakeThreshold ||
//             deltaZ > shakeThreshold) {
//           _handleShakeLogout(); // Call logout function
//         }
//       });
//     } catch (e) {
//       debugPrint("Error initializing shake detection: $e");
//     }
//   }

//   /// **Logout Function when Shake is Detected**
//   void _handleShakeLogout() {
//     debugPrint("Shake detected! Logging out...");
//     Navigator.pushReplacementNamed(
//         context, '/login'); // Navigate to login screen
//   }

//   /// **Splash Screen UI**
//   Widget _buildLogoScreen() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.pink[50]!, Colors.white],
//         ),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: Image.asset('assets/images/logo.png')),
//             const SizedBox(height: 12),
//             const Text(
//               'Shikshyadwar',
//               style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF333333)),
//             ),
//             const SizedBox(height: 40),
//             const CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B4EFF)),
//               strokeWidth: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: _buildLogoScreen());
//   }
// }
