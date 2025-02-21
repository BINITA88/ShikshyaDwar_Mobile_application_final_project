// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// // import 'package:shikshyadwar_mobile_application_project/core/theme/app_theme.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view/splash_view.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';

// // class App extends StatelessWidget {
// //   const App({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Student Management',
// //       theme: AppTheme.getApplicationTheme(isDarkMode: false),
// //       home: BlocProvider.value(
// //         value: getIt<SplashCubit>(),
// //         child: SplashView(),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/core/theme/app_theme.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
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
//         BlocProvider(create: (context) => getIt<ChatBloc>()), // Added ChatBloc
//         BlocProvider(create: (context) => getIt<AuthBloc>()), // Added ChatBloc
//         BlocProvider(
//             create: (context) => getIt<LoginBloc>()), // ✅ Added LoginBloc
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Student Management',
//         theme: AppTheme.getApplicationTheme(isDarkMode: false),
//         home: SplashView(),
//       ),
//     );
//   }
// }
// // kata rkahni logout ko

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/core/theme/app_theme.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view/splash_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view_model/bloc/chat_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SplashCubit>()),
        BlocProvider(create: (context) => getIt<ChatBloc>()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<LoginBloc>()),
      ],
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
