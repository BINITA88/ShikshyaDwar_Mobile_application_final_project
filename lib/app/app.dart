

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/core/theme/app_theme.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/profile/get_me_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view/splash_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view_model/bloc/chat_bloc.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => getIt<SplashCubit>()),
//         BlocProvider(create: (context) => getIt<HomeCubit>()),
//         BlocProvider(create: (context) => getIt<ChatBloc>()),
//         BlocProvider(create: (context) => getIt<AuthBloc>()),
//         BlocProvider(create: (context) => getIt<LoginBloc>()),

//         // BlocProvider(
//         //     create: (context) => getIt<GetMeBloc>()), // ✅ Added GetMeBloc
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Student Management',
//         theme: AppTheme.getApplicationTheme(isDarkMode: false),
//         home: SplashView(),
//         builder: (context, child) {
//           return WillPopScope(
//             onWillPop: () async {
//               bool shouldLogout = await showLogoutDialog(context);
//               return shouldLogout;
//             },
//             child: child!,
//           );
//         },
//       ),
//     );
//   }

//   Future<bool> showLogoutDialog(BuildContext context) async {
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
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => const LoginView()),
//                   );
//                 },
//                 child: const Text("Logout"),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/core/shake_detector/shake_detector.dart';
import 'package:shikshyadwar_mobile_application_project/core/theme/app_theme.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view/splash_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view_model/bloc/chat_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late ShakeDetector _shakeDetector;

  @override
  void initState() {
    super.initState();
    
    // Initialize the shake detector
    _shakeDetector = ShakeDetector(onShake: () {
      BlocProvider.of<AuthBloc>(context).add(ShakeLogoutRequested());
    });

    // Start listening for shake events
    _shakeDetector.startListening();
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SplashCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<ChatBloc>()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<LoginBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Student Management',
          theme: AppTheme.getApplicationTheme(isDarkMode: false),
          home: SplashView(),
          builder: (context, child) {
            return WillPopScope(
              onWillPop: () async {
                bool shouldLogout = await showLogoutDialog(context);
                return shouldLogout;
              },
              child: child!,
            );
          },
        ),
      ),
    );
  }

  Future<bool> showLogoutDialog(BuildContext context) async {
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
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
