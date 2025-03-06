// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view/course_detail_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/widget/top_categories.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   _DashboardViewState createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   late Timer _carouselTimer;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _startCarouselAutoPlay();
//   }

//   @override
//   void dispose() {
//     _carouselTimer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startCarouselAutoPlay() {
//     _carouselTimer = Timer.periodic(const Duration(seconds: 2), (_) {
//       if (!mounted) return;

//       final cubit = context.read<HomeCubit>();
//       int nextIndex = (cubit.state.currentCarouselIndex + 1) %
//           cubit.state.carouselImages.length;

//       cubit.updateCarouselIndex(nextIndex);

//       _pageController.animateToPage(
//         nextIndex,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<CourseBloc>()..add(CourseLoad()),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             // ✅ Carousel Section (Full Width)
//             SizedBox(
//               height: 250,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   BlocBuilder<HomeCubit, HomeState>(
//                     builder: (context, state) {
//                       return PageView.builder(
//                         controller: _pageController,
//                         onPageChanged: (index) {
//                           context.read<HomeCubit>().updateCarouselIndex(index);
//                         },
//                         itemCount: state.carouselImages.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width, // ✅ Full Width
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   blurRadius: 4,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                               image: DecorationImage(
//                                 image: AssetImage(state.carouselImages[index]),
//                                 fit: BoxFit
//                                     .cover, // ✅ Ensure full width coverage
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     left: 0,
//                     right: 0,
//                     child: BlocBuilder<HomeCubit, HomeState>(
//                       builder: (context, state) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             state.carouselImages.length,
//                             (index) => AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               width: state.currentCarouselIndex == index
//                                   ? 12.0
//                                   : 8.0,
//                               height: 8.0,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 3.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(4),
//                                 color: state.currentCarouselIndex == index
//                                     ? Theme.of(context).primaryColor
//                                     : Colors.grey,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const Positioned(
//                     bottom: -5,
//                     left: 0,
//                     right: 0,
//                     child: TopCategories(),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
// // 📌 Full-Width Motivational Quote Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0), // Full width
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 6,
//                         spreadRadius: 2,
//                         offset: const Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.center, // Center content
//                     children: [
//                       const Icon(Icons.lightbulb,
//                           color: Colors.orange, size: 40),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "“Education is the most powerful weapon which you can use to change the world.”",
//                         style: TextStyle(
//                             fontSize: 16, fontStyle: FontStyle.italic),
//                         textAlign: TextAlign.center, // Center text
//                       ),
//                       const SizedBox(height: 5),
//                       const Text(
//                         "- Nelson Mandela",
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // ✅ Recommended Classes Section
//             const SizedBox(height: 15),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Available Courses",
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text("View All"),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             // ✅ Courses List (Scroll Enabled & Fixed Overflow)
//             BlocBuilder<CourseBloc, CourseState>(
//               builder: (context, state) {
//                 if (state.isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state.error != null) {
//                   return Center(
//                     child: Text(
//                       'Error: ${state.error}',
//                       style: const TextStyle(color: Colors.red, fontSize: 16),
//                     ),
//                   );
//                 } else if (state.courses.isEmpty) {
//                   return const Center(child: Text('No Courses Available'));
//                 } else {
//                   return SizedBox(
//                     height: 230, // ✅ Adjusted to fit without overflow
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: state.courses.length,
//                       itemBuilder: (context, index) {
//                         final course = state.courses[index];
//                         String fullImageUrl =
//                             (course.courseImage?.isNotEmpty == true)
//                                 ? "http://10.0.2.2:9000/${course.courseImage}"
//                                 : "https://via.placeholder.com/150";

//                         return Container(
//                           width: 180, // ✅ Smaller size for better fit
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 4,
//                                 spreadRadius: 1,
//                                 offset: const Offset(2, 2),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // 📌 Course Image
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(12)),
//                                 child: Image.network(
//                                   fullImageUrl,
//                                   height: 80,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Icon(Icons.image_not_supported,
//                                           size: 60),
//                                 ),
//                               ),

//                               // 📌 Course Details
//                               Expanded(
//                                 child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 6),
//                                     child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(course.courseName,
//                                               style: const TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold)),
//                                           Text(
//                                               "Instructor: ${course.instructor}",
//                                               style: const TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.grey)),
//                                           Text(
//                                             course.coursePrice != null
//                                                 ? "Rs. ${course.coursePrice}"
//                                                 : "Price Not Available",
//                                             style: const TextStyle(
//                                                 color: Colors.blueAccent,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                           const SizedBox(height: 6),

//                                           // 📌 View Details Button

//                                           // 📌 View Details Button
//                                           SizedBox(
//                                             width: double
//                                                 .infinity, // ✅ Make the button fill available space
//                                             child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor:
//                                                     Colors.pink.shade700,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 padding: const EdgeInsets
//                                                     .symmetric(
//                                                     vertical:
//                                                         10), // ✅ Increase button height
//                                               ),
//                                               onPressed: () {
//                                                 final courseBloc =
//                                                     context.read<CourseBloc>();

//                                                 if (course.courseId != null &&
//                                                     course
//                                                         .courseId!.isNotEmpty) {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           BlocProvider.value(
//                                                         value: courseBloc,
//                                                         child: CourseDetailView(
//                                                             courseId: course
//                                                                 .courseId!),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(
//                                                     const SnackBar(
//                                                         content: Text(
//                                                             "Invalid Course ID")),
//                                                   );
//                                                 }
//                                               },
//                                               child: const Text(
//                                                 "View Details",
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors
//                                                         .white), // ✅ Slightly larger font
//                                               ),
//                                             ),
//                                           ),
//                                         ])),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startCarouselAutoPlay();
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startCarouselAutoPlay() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;

      final cubit = context.read<HomeCubit>();
      int nextIndex = (cubit.state.currentCarouselIndex + 1) %
          cubit.state.carouselImages.length;

      cubit.updateCarouselIndex(nextIndex);

      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CourseBloc>()..add(CourseLoad()),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Existing Carousel Section
            SizedBox(
              height: 290,
              width: double.infinity,
              child: Stack(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          context.read<HomeCubit>().updateCarouselIndex(index);
                        },
                        itemCount: state.carouselImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
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
            const SizedBox(height: 20),

            // New Quick Action Cards Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // children: [
                      //   _buildQuickActionCard(
                      //     context,
                      //     icon: Icons.book,
                      //     title: "My Courses",
                      //     color: Colors.blue.shade100,
                      //     onTap: () {
                      //       // TODO: Navigate to My Courses
                      //     },
                      //   ),
                      //   const SizedBox(width: 10),
                      //   _buildQuickActionCard(
                      //     context,
                      //     icon: Icons.grid_view,
                      //     title: "Categories",
                      //     color: Colors.green.shade100,
                      //     onTap: () {
                      //       // TODO: Navigate to Categories
                      //     },
                      //   ),
                      //   const SizedBox(width: 10),
                      //   _buildQuickActionCard(
                      //     context,
                      //     icon: Icons.favorite,
                      //     title: "Wishlist",
                      //     color: Colors.red.shade100,
                      //     onTap: () {
                      //       // TODO: Navigate to Wishlist
                      //     },
                      //   ),
                      //   const SizedBox(width: 15),
                      //   _buildQuickActionCard(
                      //     context,
                      //     icon: Icons.favorite,
                      //     title: "Wishlist",
                      //     color: Colors.red.shade100,
                      //     onTap: () {
                      //       // TODO: Navigate to Wishlist
                      //     },
                      //   ),
                      // ],
                      children: [
                        _buildQuickActionCard(
                          context,
                          icon: Icons.book,
                          title: "My Courses",
                          color: Colors.blue.shade100,
                          onTap: () {
                            // Navigate to My Courses page
                          },
                        ),
                        const SizedBox(width: 10),
                        _buildQuickActionCard(
                          context,
                          icon: Icons.grid_view,
                          title: "Categories",
                          color: Colors.green.shade100,
                          onTap: () {
                            // Navigate to Categories page
                          },
                        ),
                        const SizedBox(width: 10),
                        _buildQuickActionCard(
                          context,
                          icon: Icons.favorite,
                          title: "Wishlist",
                          color: Colors.red.shade100,
                          onTap: () {
                            // Navigate to Wishlist page
                          },
                        ),
                        const SizedBox(width: 10),
                        _buildQuickActionCard(
                          context,
                          icon: Icons.shopping_cart,
                          title: "Bookings",
                          color: Colors.orange.shade100,
                          onTap: () {
                            // Navigate to My Bookings page
                          },
                        ),
                        const SizedBox(width: 10),
                        _buildQuickActionCard(
                          context,
                          icon: Icons.payment,
                          title: "Payments",
                          color: Colors.purple.shade100,
                          onTap: () {
                            // Navigate to Payments page
                          },
                        ),
                        const SizedBox(width: 10),
                        _buildQuickActionCard(
                          context,
                          icon: Icons.person,
                          title: "Profile",
                          color: Colors.cyan.shade100,
                          onTap: () {
                            // Navigate to Profile page
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // // // Replace the existing Motivational Quote section with this
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           Colors.deepPurple.shade50,
            //           Colors.deepPurple.shade100,
            //         ],
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //       ),
            //       borderRadius: BorderRadius.circular(16),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.1),
            //           blurRadius: 10,
            //           spreadRadius: 2,
            //           offset: const Offset(2, 4),
            //         ),
            //       ],
            //     ),
            //     child: Column(
            //       children: [
            //         // Learning Progress Header
            //         Padding(
            //           padding: const EdgeInsets.all(16.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Your Learning Journey",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .titleMedium
            //                         ?.copyWith(
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.deepPurple.shade800,
            //                         ),
            //                   ),
            //                   Text(
            //                     "Keep pushing your boundaries",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodySmall
            //                         ?.copyWith(
            //                           color: Colors.deepPurple.shade600,
            //                         ),
            //                   ),
            //                 ],
            //               ),
            //               CircleAvatar(
            //                 backgroundColor: Colors.deepPurple.shade100,
            //                 child: Icon(
            //                   Icons.trending_up,
            //                   color: Colors.deepPurple.shade700,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),

            //         // Learning Progress Indicators
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //           child: Column(
            //             children: [
            //               // Total Courses Progress
            //               _buildProgressIndicator(
            //                 context,
            //                 title: "Completed Courses",
            //                 progress: 0.65,
            //                 progressColor: Colors.green.shade400,
            //                 backgroundColor: Colors.green.shade100,
            //                 value: "6/10",
            //               ),
            //               const SizedBox(height: 10),

            //               // Learning Hours Progress
            //               _buildProgressIndicator(
            //                 context,
            //                 title: "Total Learning Hours",
            //                 progress: 0.45,
            //                 progressColor: Colors.blue.shade400,
            //                 backgroundColor: Colors.blue.shade100,
            //                 value: "45/100 hrs",
            //               ),
            //             ],
            //           ),
            //         ),

            //         // Recommendation Section
            //         Padding(
            //           padding: const EdgeInsets.all(16.0),
            //           child: Container(
            //             padding: const EdgeInsets.all(12),
            //             decoration: BoxDecoration(
            //               color: Colors.white70,
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.light_mode,
            //                   color: Colors.orange.shade600,
            //                 ),
            //                 const SizedBox(width: 10),
            //                 Expanded(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         "Recommended Next Course",
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .bodyMedium
            //                             ?.copyWith(
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                       ),
            //                       Text(
            //                         "Advanced Web Development",
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .bodySmall
            //                             ?.copyWith(
            //                               color: Colors.grey.shade600,
            //                             ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 ElevatedButton(
            //                   onPressed: () {
            //                     // TODO: Navigate to recommended course
            //                   },
            //                   style: ElevatedButton.styleFrom(
            //                     backgroundColor: Colors.deepPurple.shade500,
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                     ),
            //                   ),
            //                   child: const Text(
            //                     "Start",
            //                     style: TextStyle(color: Colors.white),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Existing Courses Section
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Courses",
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

            // Existing Course List
            BlocBuilder<CourseBloc, CourseState>(
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
                  return SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses[index];
                        String fullImageUrl =
                            (course.courseImage?.isNotEmpty == true)
                                ? "http://10.0.2.2:9000/${course.courseImage}"
                                : "https://via.placeholder.com/150";

                        return Container(
                          width: 180,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  fullImageUrl,
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported,
                                          size: 60),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(course.courseName,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Text("Instructor: ${course.instructor}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text(
                                        course.coursePrice != null
                                            ? "Rs. ${course.coursePrice}"
                                            : "Price Not Available",
                                        style: const TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.pink.shade700,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                          ),
                                          onPressed: () {
                                            final courseBloc =
                                                context.read<CourseBloc>();

                                            if (course.courseId != null &&
                                                course.courseId!.isNotEmpty) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider.value(
                                                    value: courseBloc,
                                                    child: CourseDetailView(
                                                        courseId:
                                                            course.courseId!),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Invalid Course ID")),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            "View Details",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

// Helper method for progress indicators
  Widget _buildProgressIndicator(
    BuildContext context, {
    required String title,
    required double progress,
    required Color progressColor,
    required Color backgroundColor,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade700,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  // New Helper Method for Quick Action Cards
  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: Colors.black54),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view/course_detail_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/widget/top_categories.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   _DashboardViewState createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   late Timer _carouselTimer;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _startCarouselAutoPlay();
//   }

//   @override
//   void dispose() {
//     _carouselTimer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startCarouselAutoPlay() {
//     _carouselTimer = Timer.periodic(const Duration(seconds: 2), (_) {
//       if (!mounted) return;

//       final cubit = context.read<HomeCubit>();
//       int nextIndex = (cubit.state.currentCarouselIndex + 1) %
//           cubit.state.carouselImages.length;

//       cubit.updateCarouselIndex(nextIndex);

//       _pageController.animateToPage(
//         nextIndex,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<CourseBloc>()..add(CourseLoad()),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Existing Carousel Section
//             SizedBox(
//               height: 250,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   BlocBuilder<HomeCubit, HomeState>(
//                     builder: (context, state) {
//                       return PageView.builder(
//                         controller: _pageController,
//                         onPageChanged: (index) {
//                           context.read<HomeCubit>().updateCarouselIndex(index);
//                         },
//                         itemCount: state.carouselImages.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   blurRadius: 4,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                               image: DecorationImage(
//                                 image: AssetImage(state.carouselImages[index]),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     left: 0,
//                     right: 0,
//                     child: BlocBuilder<HomeCubit, HomeState>(
//                       builder: (context, state) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             state.carouselImages.length,
//                             (index) => AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               width: state.currentCarouselIndex == index
//                                   ? 12.0
//                                   : 8.0,
//                               height: 8.0,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 3.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(4),
//                                 color: state.currentCarouselIndex == index
//                                     ? Theme.of(context).primaryColor
//                                     : Colors.grey,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const Positioned(
//                     bottom: -5,
//                     left: 0,
//                     right: 0,
//                     child: TopCategories(),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Minimalist Quick Actions Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Quick Access",
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple.shade800,
//                         ),
//                   ),
//                   const SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         _buildMinimalistActionCard(
//                           context,
//                           icon: Icons.book_online,
//                           title: "My Learning",
//                           color: Colors.blue.shade50,
//                           onTap: () {
//                             // TODO: Navigate to My Courses
//                           },
//                         ),
//                         const SizedBox(width: 10),
//                         _buildMinimalistActionCard(
//                           context,
//                           icon: Icons.leaderboard,
//                           title: "Progress",
//                           color: Colors.green.shade50,
//                           onTap: () {
//                             // TODO: Navigate to Progress
//                           },
//                         ),
//                         const SizedBox(width: 10),
//                         _buildMinimalistActionCard(
//                           context,
//                           icon: Icons.settings,
//                           title: "Settings",
//                           color: Colors.grey.shade50,
//                           onTap: () {
//                             // TODO: Navigate to Settings
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Courses Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Explore Courses",
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple.shade800,
//                         ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       "View All",
//                       style: TextStyle(color: Colors.deepPurple.shade700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Course List
//             BlocBuilder<CourseBloc, CourseState>(
//               builder: (context, state) {
//                 if (state.isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state.error != null) {
//                   return Center(
//                     child: Text(
//                       'Error: ${state.error}',
//                       style: const TextStyle(color: Colors.red, fontSize: 16),
//                     ),
//                   );
//                 } else if (state.courses.isEmpty) {
//                   return const Center(child: Text('No Courses Available'));
//                 } else {
//                   return SizedBox(
//                     height: 250,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: state.courses.length,
//                       itemBuilder: (context, index) {
//                         final course = state.courses[index];
//                         String fullImageUrl =
//                             (course.courseImage?.isNotEmpty == true)
//                                 ? "http://10.0.2.2:9000/${course.courseImage}"
//                                 : "https://via.placeholder.com/150";

//                         return Container(
//                           width: 200,
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 6,
//                                 spreadRadius: 1,
//                                 offset: const Offset(2, 2),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(12)),
//                                 child: Image.network(
//                                   fullImageUrl,
//                                   height: 120,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Icon(Icons.image_not_supported,
//                                           size: 60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             course.courseName,
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             "By ${course.instructor}",
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.grey.shade600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             course.coursePrice != null
//                                                 ? "Rs. ${course.coursePrice}"
//                                                 : "Free",
//                                             style: TextStyle(
//                                               color: Colors.deepPurple.shade700,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               final courseBloc =
//                                                   context.read<CourseBloc>();

//                                               if (course.courseId != null &&
//                                                   course.courseId!.isNotEmpty) {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         BlocProvider.value(
//                                                       value: courseBloc,
//                                                       child: CourseDetailView(
//                                                           courseId:
//                                                               course.courseId!),
//                                                     ),
//                                                   ),
//                                                 );
//                                               } else {
//                                                 ScaffoldMessenger.of(context)
//                                                     .showSnackBar(
//                                                   const SnackBar(
//                                                       content: Text(
//                                                           "Invalid Course ID")),
//                                                 );
//                                               }
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor:
//                                                   Colors.deepPurple.shade500,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 6),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               "Enroll",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 12),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Minimalist Quick Action Card
//   Widget _buildMinimalistActionCard(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 100,
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               size: 32,
//               color: Colors.deepPurple.shade700,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.deepPurple.shade800,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
