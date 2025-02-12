import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/bottom_view/account_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/bottom_view/course_view.dart';
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
        //  CourseView(),
        Center(child: Text('Admission')), // Placeholder for "Admission"
        const AccountView(),
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
