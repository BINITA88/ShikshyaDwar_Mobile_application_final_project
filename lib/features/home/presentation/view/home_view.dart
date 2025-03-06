// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

// // class HomeView extends StatefulWidget {
// //   const HomeView({super.key});

// //   @override
// //   _HomeViewState createState() => _HomeViewState();
// // }

// // class _HomeViewState extends State<HomeView> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('ShikshyaDwar'),
// //         centerTitle: true,
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.logout, color: Colors.white),
// //             onPressed: () async {
// //               bool shouldLogout = await _showLogoutDialog(context);
// //               if (shouldLogout) {
// //                 context.read<AuthBloc>().add(AuthLogoutRequested());
// //                 Navigator.of(context).pushReplacement(
// //                   MaterialPageRoute(builder: (context) => const LoginView()),
// //                 );
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //       body: BlocBuilder<HomeCubit, HomeState>(
// //         builder: (context, state) {
// //           return state.views[state.selectedIndex];
// //         },
// //       ),
// //       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
// //         builder: (context, state) {
// //           return BottomNavigationBar(
// //             items: const <BottomNavigationBarItem>[
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.dashboard),
// //                 label: 'Dashboard',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.event_seat_sharp),
// //                 label: 'MockTest',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.schedule_rounded),
// //                 label: 'Routine',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.notifications_active),
// //                 label: 'Notice',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.message_rounded),
// //                 label: 'Message',
// //               ),
// //                  BottomNavigationBarItem(
// //                 icon: Icon(Icons.person),
// //                 label: 'Profile',
// //               ),
// //             ],
// //             currentIndex: state.selectedIndex,
// //             selectedItemColor: Colors.black,
// //             unselectedItemColor: Colors.white,
// //             onTap: (index) {
// //               context.read<HomeCubit>().onTabTapped(index);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   /// Show Logout Confirmation Dialog
// //   Future<bool> _showLogoutDialog(BuildContext context) async {
// //     return await showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text("Logout"),
// //             content: const Text("Are you sure you want to log out?"),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.of(context).pop(false),
// //                 child: const Text("Cancel"),
// //               ),
// //               TextButton(
// //                 onPressed: () => Navigator.of(context).pop(true),
// //                 child: const Text("Logout"),
// //               ),
// //             ],
// //           ),
// //         ) ??
// //         false;
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('ShikshyaDwar'),
//             centerTitle: true,
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.logout, color: Colors.white),
//                 onPressed: () async {
//                   bool shouldLogout = await _showLogoutDialog(context);
//                   if (shouldLogout) {
//                     context.read<AuthBloc>().add(AuthLogoutRequested());
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                           builder: (context) => const LoginView()),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: state.views[state.selectedIndex], // ✅ Fix: Uses selected index

//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard),
//                 label: 'Dashboard',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.event_seat_sharp),
//                 label: 'MockTest',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.schedule_rounded),
//                 label: 'Routine',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.notifications_active),
//                 label: 'Notice',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.message_rounded),
//                 label: 'Message',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile', // ✅ Fix: Profile tab exists now
//               ),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.black,
//             unselectedItemColor: const Color.fromARGB(255, 255, 254, 254),
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           ),
//         );
//       },
//     );
//   }

//   /// ✅ **Show Logout Confirmation Dialog**
//   Future<bool> _showLogoutDialog(BuildContext context) async {
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Logout"),
//             content: const Text("Are you sure you want to log out?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: const Text("Logout"),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
// }

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   static const double shakeThreshold = 2.0; // Adjust sensitivity
//   static const int shakeCooldownMs = 1500; // Prevent multiple triggers
//   DateTime? _lastShakeTime;
//   UserAccelerometerEvent? _previousEvent;
//   late StreamSubscription<UserAccelerometerEvent> _accelerometerSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startShakeDetection();
//   }

//   void _startShakeDetection() {
//     _accelerometerSubscription =
//         userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       if (_previousEvent == null) {
//         _previousEvent = event; // Initialize _previousEvent
//         return;
//       }

//       double deltaX = event.x - _previousEvent!.x;
//       double deltaY = event.y - _previousEvent!.y;
//       double deltaZ = event.z - _previousEvent!.z;

//       double acceleration =
//           sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

//       print("Acceleration: $acceleration"); // Debug log

//       if (acceleration > shakeThreshold) {
//         final now = DateTime.now();
//         if (_lastShakeTime == null ||
//             now.difference(_lastShakeTime!).inMilliseconds > shakeCooldownMs) {
//           _lastShakeTime = now;
//           _handleShake();
//         }
//       }

//       _previousEvent = event;
//     });
//   }

//   void _handleShake() {
//     if (mounted) {
//       _accelerometerSubscription
//           .cancel(); // Stop listening to avoid multiple triggers
//       context.read<AuthBloc>().add(AuthLogoutRequested());
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginView()),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('ShikshyaDwar'),
//             centerTitle: true,
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.logout, color: Colors.white),
//                 onPressed: () async {
//                   bool shouldLogout = await _showLogoutDialog(context);
//                   if (shouldLogout) {
//                     context.read<AuthBloc>().add(AuthLogoutRequested());
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                           builder: (context) => const LoginView()),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: state.views[state.selectedIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.dashboard), label: 'Dashboard'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.event_seat_sharp), label: 'MockTest'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.schedule_rounded), label: 'Routine'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.notifications_active), label: 'Notice'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.message_rounded), label: 'Message'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.person), label: 'Profile'),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.black,
//             unselectedItemColor: Colors.white,
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           ),
//         );
//       },
//     );
//   }

//   Future<bool> _showLogoutDialog(BuildContext context) async {
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Logout"),
//             content: const Text("Are you sure you want to log out?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: const Text("Logout"),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
// }

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

// class HomeView extends StatefulWidget {
//   final int userRole; // ✅ Accept user role (0 = Student, 2 = Instructor)

//   const HomeView({super.key, required this.userRole});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   static const double shakeThreshold = 2.0; // Adjust sensitivity
//   static const int shakeCooldownMs = 1500; // Prevent multiple triggers
//   DateTime? _lastShakeTime;
//   UserAccelerometerEvent? _previousEvent;
//   late StreamSubscription<UserAccelerometerEvent> _accelerometerSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startShakeDetection();
//   }

//   void _startShakeDetection() {
//     _accelerometerSubscription =
//         userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       if (_previousEvent == null) {
//         _previousEvent = event;
//         return;
//       }

//       double deltaX = event.x - _previousEvent!.x;
//       double deltaY = event.y - _previousEvent!.y;
//       double deltaZ = event.z - _previousEvent!.z;

//       double acceleration =
//           sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

//       print("Acceleration: $acceleration"); // Debug log

//       if (acceleration > shakeThreshold) {
//         final now = DateTime.now();
//         if (_lastShakeTime == null ||
//             now.difference(_lastShakeTime!).inMilliseconds > shakeCooldownMs) {
//           _lastShakeTime = now;
//           _handleShake();
//         }
//       }

//       _previousEvent = event;
//     });
//   }

//   void _handleShake() {
//     if (mounted) {
//       _accelerometerSubscription.cancel();
//       context.read<AuthBloc>().add(AuthLogoutRequested());
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginView()),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('ShikshyaDwar'),
//             centerTitle: true,
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.logout, color: Colors.white),
//                 onPressed: () async {
//                   bool shouldLogout = await _showLogoutDialog(context);
//                   if (shouldLogout) {
//                     context.read<AuthBloc>().add(AuthLogoutRequested());
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                           builder: (context) => const LoginView()),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: state.views[state.selectedIndex],
//           bottomNavigationBar: _buildBottomNavigationBar(context, state),
//         );
//       },
//     );
//   }

//   /// ✅ **Dynamically Filter Tabs Based on Role**
//   Widget _buildBottomNavigationBar(BuildContext context, HomeState state) {
//     List<BottomNavigationBarItem> studentItems = const [
//       BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
//       BottomNavigationBarItem(icon: Icon(Icons.event_seat_sharp), label: 'MockTest'),
//       BottomNavigationBarItem(icon: Icon(Icons.schedule_rounded), label: 'Routine'),
//       BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Notice'),
//       BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: 'Message'),
//       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//     ];

//     List<BottomNavigationBarItem> instructorItems = const [
//       BottomNavigationBarItem(icon: Icon(Icons.schedule_rounded), label: 'Routine'),
//       BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Notice'),
//       BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: 'Message'),
//       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//     ];

//     List<BottomNavigationBarItem> navigationItems =
//         (widget.userRole == 0) ? studentItems : instructorItems;

//     return BottomNavigationBar(
//       items: navigationItems,
//       currentIndex: state.selectedIndex,
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.white,
//       onTap: (index) {
//         context.read<HomeCubit>().onTabTapped(index);
//       },
//     );
//   }

//   Future<bool> _showLogoutDialog(BuildContext context) async {
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Logout"),
//             content: const Text("Are you sure you want to log out?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: const Text("Logout"),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
// }

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatefulWidget {
  final int userRole; // ✅ Accept user role (1 = Student, 2 = Instructor)

  const HomeView({super.key, required this.userRole});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const double shakeThreshold = 2.0; // Adjust sensitivity
  static const int shakeCooldownMs = 1500; // Prevent multiple triggers
  DateTime? _lastShakeTime;
  UserAccelerometerEvent? _previousEvent;
  late StreamSubscription<UserAccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _startShakeDetection();
  }

  void _startShakeDetection() {
    _accelerometerSubscription =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      if (_previousEvent == null) {
        _previousEvent = event;
        return;
      }

      double deltaX = event.x - _previousEvent!.x;
      double deltaY = event.y - _previousEvent!.y;
      double deltaZ = event.z - _previousEvent!.z;

      double acceleration =
          sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

      print("Acceleration: $acceleration"); // Debug log

      if (acceleration > shakeThreshold) {
        final now = DateTime.now();
        if (_lastShakeTime == null ||
            now.difference(_lastShakeTime!).inMilliseconds > shakeCooldownMs) {
          _lastShakeTime = now;
          _handleShake();
        }
      }

      _previousEvent = event;
    });
  }

  void _handleShake() {
    if (mounted) {
      _accelerometerSubscription.cancel();
      context.read<AuthBloc>().add(AuthLogoutRequested());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ShikshyaDwar'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  bool shouldLogout = await _showLogoutDialog(context);
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  }
                },
              ),
            ],
          ),
          body: state.views[state.selectedIndex],
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
        );
      },
    );
  }

  /// ✅ **Dynamically Filter Tabs Based on Role**
  Widget _buildBottomNavigationBar(BuildContext context, HomeState state) {
    List<BottomNavigationBarItem> studentItems = const [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
      BottomNavigationBarItem(
          icon: Icon(Icons.event_seat_sharp), label: 'MockTest'),
      BottomNavigationBarItem(
          icon: Icon(Icons.schedule_rounded), label: 'Routine'),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active), label: 'Notice'),
      BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded), label: 'Message'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];

    List<BottomNavigationBarItem> instructorItems = const [
      BottomNavigationBarItem(
          icon: Icon(Icons.schedule_rounded), label: 'Routine'),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active), label: 'Notice'),
      BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded), label: 'Message'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];

    List<BottomNavigationBarItem> navigationItems =
        (widget.userRole == 0) ? studentItems : instructorItems;

    return BottomNavigationBar(
      items: navigationItems,
      currentIndex: state.selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      onTap: (index) {
        context.read<HomeCubit>().onTabTapped(index);
      },
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Logout"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
