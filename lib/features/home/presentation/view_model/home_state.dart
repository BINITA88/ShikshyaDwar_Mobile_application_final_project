import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/presentation/view/batch_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/presentation/view_model/batch_bloc.dart';
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
        // Dashboard View
        const DashboardView(), // Replace this with your actual DashboardView widget
        // Course View
        const CourseView(), // Replace this with your actual CourseView widget
        // Batch View
        BlocProvider(
          create: (context) => getIt<BatchBloc>(),
          child: BatchView(),
        ),
        // Account View
        const AccountView(), // Replace this with your actual AccountView widget
      ],
      carouselImages: [],
      products: [],
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
