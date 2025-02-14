import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view/course_detail_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/widget/top_categories.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late Timer _carouselTimer;

  @override
  void initState() {
    super.initState();
    _startCarouselAutoPlay();
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    super.dispose();
  }

  void _startCarouselAutoPlay() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final cubit = context.read<HomeCubit>();
      int nextIndex = (cubit.state.currentCarouselIndex + 1) %
          cubit.state.carouselImages.length;
      cubit.updateCarouselIndex(nextIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CourseBloc>()..add(CourseLoad()),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ Carousel Section
            SizedBox(
              height: 270,
              width: double.infinity,
              child: Stack(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return PageView.builder(
                        onPageChanged: (index) {
                          context.read<HomeCubit>().updateCarouselIndex(index);
                        },
                        itemCount: state.carouselImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(state.carouselImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            state.carouselImages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: state.currentCarouselIndex == index
                                  ? 12.0
                                  : 8.0,
                              height: 8.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: state.currentCarouselIndex == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Positioned(
                    bottom: -5,
                    left: 0,
                    right: 0,
                    child: TopCategories(),
                  ),
                ],
              ),
            ),

            // ✅ Recommended Classes Header
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended Classes",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("View All"),
                  ),
                ],
              ),
            ),

            // ✅ Horizontal Course List with "Add to Schedule" Navigation
            SizedBox(
              height: 270,
              child: BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.error != null) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  } else if (state.courses.isEmpty) {
                    return const Center(child: Text('No Courses Available'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses[index];

                        // ✅ Image URL Handling
                        String fullImageUrl = (course.courseImage?.isNotEmpty ==
                                true)
                            ? "http://10.0.2.2:9000/${course.courseImage}" // Remove /public/uploads/ if already included
                            : "https://via.placeholder.com/150";

                        return Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // ✅ Course Image
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    fullImageUrl,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Icon(Icons.image_not_supported,
                                            size: 100),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // ✅ Course Name
                                        Text(
                                          course.courseName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        // ✅ Instructor Name
                                        Text(
                                          "Instructor: ${course.instructor}",
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 2),
                                        // ✅ Course Duration
                                        Text(
                                          course.duration,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blueAccent),
                                        ),
                                        // ✅ "Add to Schedule" Button
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.amber.shade700,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              final courseBloc =
                                                  context.read<CourseBloc>();

                                              // ✅ Navigate to Course Detail Page
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider.value(
                                                    value:
                                                        courseBloc, // ✅ Pass existing Bloc instance
                                                    child: CourseDetailView(
                                                        courseId:
                                                            course.courseId ??
                                                                ''),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Add to Schedule",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
