import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/view/chat_screen.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view/course_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/bottom_view/dashboard_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;
  final int currentCarouselIndex;
  final List<String> carouselImages;
  final List<Map<String, String?>> products;

  const HomeState({
    required this.selectedIndex,
    required this.views,
    this.currentCarouselIndex = 0,
    required this.carouselImages,
    required this.products,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const DashboardView(),
        BlocProvider(
          create: (_) => GetIt.instance<
              BookingBloc>(), // Ensure GetIt is properly initialized
          child: BookingFormView(),
        ),
        Center(child: Text('Admission')), // Placeholder for "Admission"
        const ChatScreen(
          receiverId: '',
          userId: '',
        ),
      ],
      carouselImages: [
        'assets/images/cr1.png',
        'assets/images/cr2.png',
        'assets/images/cr3.png',
      ],
      products: [
        {
          "image": "assets/images/reading.png",
          "title": "IELTS Class",
          "date": "10 Dec 2024",
          "duration": "2 Months",
        },
        {
          "image": "assets/images/pte.png",
          "title": "PTE Class",
          "date": "11 Dec 2024",
          "duration": "2 Months",
        },
        {
          "image": "assets/images/reading.png",
          "title": "SAT Class",
          "date": "12 Dec 2024",
          "duration": "2 Months",
        },
        {
          "image": "assets/images/pte.png",
          "title": "TOEFL Class",
          "date": "13 Dec 2024",
          "duration": "2 Months",
        },
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
    int? currentCarouselIndex,
    List<String>? carouselImages,
    List<Map<String, String?>>? products,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      currentCarouselIndex: currentCarouselIndex ?? this.currentCarouselIndex,
      carouselImages: carouselImages ?? this.carouselImages,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props =>
      [selectedIndex, views, currentCarouselIndex, carouselImages, products];
}

//         import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/view/chat_screen.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/auth_remote_repository.dart/auth_remote_repository.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/bottom_view/dashboard_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';

// class HomeState extends Equatable {
//   final int selectedIndex;
//   final int currentCarouselIndex;
//   final List<String> carouselImages;
//   final List<Map<String, String?>> products;
//   final String userId; // ✅ Added userId for dynamic chat initialization

//   const HomeState({
//     required this.selectedIndex,
//     required this.currentCarouselIndex,
//     required this.carouselImages,
//     required this.products,
//     required this.userId, // ✅ User ID passed dynamically
//   });

//   /// ✅ **Initial state setup with dynamic user ID fetching**
//   static Future<HomeState> initial() async {
//     final authRepository = getIt<AuthRemoteRepository>();
//     final user = await authRepository.getCurrentUser();

//     return HomeState(
//       selectedIndex: 0,
//       currentCarouselIndex: 0,
//       userId: user.authId ?? "", // ✅ Fetch logged-in user's ID
//       carouselImages: [
//         'assets/images/cr1.png',
//         'assets/images/cr2.png',
//         'assets/images/cr3.png',
//       ],
//       products: [
//         {
//           "image": "assets/images/reading.png",
//           "title": "IELTS Class",
//           "date": "10 Dec 2024",
//           "duration": "2 Months",
//         },
//         {
//           "image": "assets/images/pte.png",
//           "title": "PTE Class",
//           "date": "11 Dec 2024",
//           "duration": "2 Months",
//         },
//         {
//           "image": "assets/images/reading.png",
//           "title": "SAT Class",
//           "date": "12 Dec 2024",
//           "duration": "2 Months",
//         },
//         {
//           "image": "assets/images/pte.png",
//           "title": "TOEFL Class",
//           "date": "13 Dec 2024",
//           "duration": "2 Months",
//         },
//       ],
//     );
//   }

//   /// ✅ **Returns the navigation views dynamically**
//   List<Widget> get views {
//     return [
//       const DashboardView(),
//       BlocProvider(
//         create: (_) => getIt<BookingBloc>(),
//         child: BookingFormView(),
//       ),
//       const Center(child: Text('Admission')), // Placeholder for "Admission"
//       ChatScreen(
//         receiverId:
//             "someReceiverId", // ✅ Replace with selected user dynamically
//         userId: userId, // ✅ Uses logged-in user ID dynamically
//       ),
//     ];
//   }

//   /// ✅ **CopyWith method to update only necessary fields**
//   HomeState copyWith({
//     int? selectedIndex,
//     int? currentCarouselIndex,
//     List<String>? carouselImages,
//     List<Map<String, String?>>? products,
//     String? userId,
//   }) {
//     return HomeState(
//       selectedIndex: selectedIndex ?? this.selectedIndex,
//       currentCarouselIndex: currentCarouselIndex ?? this.currentCarouselIndex,
//       carouselImages: carouselImages ?? this.carouselImages,
//       products: products ?? this.products,
//       userId: userId ?? this.userId,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [selectedIndex, currentCarouselIndex, carouselImages, products, userId];
// }
