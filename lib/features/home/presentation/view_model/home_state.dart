// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/profile_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view/chat_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view/list_of_users_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/view/exam_seat_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/bottom_view/dashboard_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/View/notice_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/view/routine_view.dart';

// class HomeState extends Equatable {
//   final int selectedIndex;
//   final List<Widget> views;
//   final int currentCarouselIndex;
//   final List<String> carouselImages;
//   final List<Map<String, String?>> products;

//   const HomeState({
//     required this.selectedIndex,
//     required this.views,
//     this.currentCarouselIndex = 0,
//     required this.carouselImages,
//     required this.products,
//   });

//   // ✅ **Ensure `views` is never empty**
//   static HomeState initial() {
//     return HomeState(
//       selectedIndex: 0,
//       views: [
//         const DashboardView(),
//         const ExamSeatScreen(),
//         const RoutineScreen(),
//         const NoticeViewPage(),
//         UserListScreen(),
//         // const ProfileView(),
//       ],
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

// // lets make profile all part
//   // ✅ **CopyWith method ensures immutability and controlled updates**
//   HomeState copyWith({
//     int? selectedIndex,
//     List<Widget>? views,
//     int? currentCarouselIndex,
//     List<String>? carouselImages,
//     List<Map<String, String?>>? products,
//   }) {
//     return HomeState(
//       selectedIndex: selectedIndex ?? this.selectedIndex,
//       views: views ?? this.views,
//       currentCarouselIndex: currentCarouselIndex ?? this.currentCarouselIndex,
//       carouselImages: carouselImages ?? this.carouselImages,
//       products: products ?? this.products,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [selectedIndex, views, currentCarouselIndex, carouselImages, products];
// }
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/profile_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view/list_of_users_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/view/exam_seat_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/View/notice_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/view/routine_view.dart';

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

  // ✅ **Ensure `views` is never empty**
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const DashboardView(),
        const ExamSeatScreen(),
        const RoutineScreen(),
        const NoticeViewPage(),
        const UserListScreen(),
        const ProfileView(), // ✅ Fixed: Added Profile View
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

  // ✅ **CopyWith method ensures immutability and controlled updates**
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
