// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

// class CourseDetailView extends StatelessWidget {
//   final String courseId;
//   final String baseUrl = "http://10.0.2.2:9000/";

//   const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Fetch course details when the view is opened
//     context.read<CourseBloc>().add(CourseDetailLoad(courseId));

//     return Scaffold(
//       appBar: AppBar(title: const Text("Course Details")),
//       body: BlocBuilder<CourseBloc, CourseState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Text(
//                 'Error: ${state.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           } else if (state.selectedCourse == null) {
//             return const Center(child: Text('No Course Details Available'));
//           }

//           final course = state.selectedCourse!;

//           // ✅ Ensure correct image URL
//           String fullImageUrl =
//               (course.courseImage != null && course.courseImage!.isNotEmpty)
//                   ? "$baseUrl${course.courseImage}"
//                   : "https://via.placeholder.com/150"; // Fallback image

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ✅ Course Image
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       fullImageUrl,
//                       height: 200,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         height: 200,
//                         color: Colors.grey[300],
//                         child: const Center(
//                           child: Icon(Icons.image_not_supported,
//                               size: 50, color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // ✅ Course Name
//                   Text(
//                     course.courseName,
//                     style: const TextStyle(
//                         fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),

//                   // ✅ Instructor Name
//                   Text(
//                     "Instructor: ${course.instructor}",
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 10),

//                   // ✅ Course Price
//                   Text(
//                     "Price: Rs.${course.coursePrice}",
//                     style: const TextStyle(fontSize: 18, color: Colors.green),
//                   ),
//                   Text(
//                     "Category: Course",
//                     style: const TextStyle(
//                         fontSize: 18, color: Color.fromARGB(255, 12, 12, 12)),
//                   ),
//                   Text(
//                     "Duration: ${course.duration}",
//                     style: const TextStyle(
//                         fontSize: 18, color: Color.fromARGB(255, 221, 116, 5)),
//                   ),
//                   const SizedBox(height: 10),

//                   // ✅ Course Description
//                   Text(
//                     "Description:",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 5),
//                   Text(
//                     course.courseDescription,
//                     style: const TextStyle(fontSize: 16),
//                   ),

//                   const SizedBox(height: 20),

//                   // ✅ "Book Now" Button
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BlocProvider(
//                               create: (context) => BookingBloc(
//                                 createBookingUsecase: GetIt.instance<
//                                     CreateBookingUsecase>(), paymentBloc: getIt(), // ✅ Correctly provide use case
//                               ),
//                               child: BookingFormView(),
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 32),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         "Book Now",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

// class CourseDetailView extends StatelessWidget {
//   final String courseId;
//   final String baseUrl = "http://10.0.2.2:9000/";

//   const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     context.read<CourseBloc>().add(CourseDetailLoad(courseId));

//     return Scaffold(
//       body: BlocBuilder<CourseBloc, CourseState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Text(
//                 'Error: ${state.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           } else if (state.selectedCourse == null) {
//             return const Center(child: Text('No Course Details Available'));
//           }

//           final course = state.selectedCourse!;
//           String fullImageUrl =
//               (course.courseImage != null && course.courseImage!.isNotEmpty)
//                   ? "$baseUrl${course.courseImage}"
//                   : "https://via.placeholder.com/150";

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ✅ Course Image (Top)
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   ),
//                   child: Image.network(
//                     fullImageUrl,
//                     height: 250,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       height: 250,
//                       color: Colors.grey[300],
//                       child: const Center(
//                         child: Icon(Icons.image_not_supported,
//                             size: 50, color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Course Name & Instructor (Horizontal)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           course.courseName,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.person, color: Colors.blueAccent),
//                           const SizedBox(width: 5),
//                           Text(
//                             course.instructor,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Course Details Section (Horizontal List)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildDetailCard(Icons.category, "Category", "Course"),
//                       _buildDetailCard(
//                           Icons.access_time, "Duration", course.duration),
//                       _buildDetailCard(Icons.attach_money, "Price",
//                           "Rs. ${course.coursePrice}"),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // ✅ Description Section
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Description",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         course.courseDescription,
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.black87),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 // ✅ "Book Now" Button
//                 Center(
//                   child: SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BlocProvider(
//                               create: (context) => BookingBloc(
//                                 createBookingUsecase:
//                                     GetIt.instance<CreateBookingUsecase>(),
//                                 paymentBloc: getIt(),
//                               ),
//                               child: BookingFormView(),
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 40),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         backgroundColor: Colors.blueAccent,
//                         elevation: 5,
//                       ),
//                       child: const Text(
//                         "Book Now",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ✅ Helper method to create small detail cards
//   Widget _buildDetailCard(IconData icon, String title, String value) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 28, color: Colors.blueAccent),
//             const SizedBox(height: 5),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               value,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

// class CourseDetailView extends StatelessWidget {
//   final String courseId;
//   final String baseUrl = "http://10.0.2.2:9000/";

//   const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     context.read<CourseBloc>().add(CourseDetailLoad(courseId));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Course Details"),
//         backgroundColor: Colors.pink.shade700, // Pink 700 Navbar
//         centerTitle: true,
//       ),
//       body: BlocBuilder<CourseBloc, CourseState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Text(
//                 'Error: ${state.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           } else if (state.selectedCourse == null) {
//             return const Center(child: Text('No Course Details Available'));
//           }

//           final course = state.selectedCourse!;
//           String fullImageUrl =
//               (course.courseImage != null && course.courseImage!.isNotEmpty)
//                   ? "$baseUrl${course.courseImage}"
//                   : "https://via.placeholder.com/150";

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ✅ Course Image (Top)
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   ),
//                   child: Image.network(
//                     fullImageUrl,
//                     height: 250,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       height: 250,
//                       color: Colors.grey[300],
//                       child: const Center(
//                         child: Icon(Icons.image_not_supported,
//                             size: 50, color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Course Name & Instructor (Horizontal)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           course.courseName,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.person, color: Colors.pinkAccent),
//                           const SizedBox(width: 5),
//                           Text(
//                             course.instructor,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Course Details Section (Horizontal List)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildDetailCard(Icons.category, "Category", "Course"),
//                       _buildDetailCard(
//                           Icons.access_time, "Duration", course.duration),
//                       _buildDetailCard(Icons.attach_money, "Price",
//                           "Rs. ${course.coursePrice}"),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // ✅ Description Section
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Description",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         course.courseDescription,
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.black87),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 // ✅ "Book Now" Button with Gradient
//                 Center(
//                   child: SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BlocProvider(
//                               create: (context) => BookingBloc(
//                                 createBookingUsecase:
//                                     GetIt.instance<CreateBookingUsecase>(),
//                                 paymentBloc: getIt(),
//                               ),
//                               child: BookingFormView(),
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 40),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         backgroundColor: Colors.pinkAccent,
//                         elevation: 5,
//                       ),
//                       child: const Text(
//                         "Book Now",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ✅ Helper method to create small detail cards
//   Widget _buildDetailCard(IconData icon, String title, String value) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 28, color: Colors.pinkAccent),
//             const SizedBox(height: 5),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               value,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

// class CourseDetailView extends StatefulWidget {
//   final String courseId;
//   final String baseUrl = "http://10.0.2.2:9000/";

//   const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

//   @override
//   _CourseDetailViewState createState() => _CourseDetailViewState();
// }

// class _CourseDetailViewState extends State<CourseDetailView> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     context.read<CourseBloc>().add(CourseDetailLoad(widget.courseId));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Course Details"),
//         backgroundColor: Colors.pink.shade700, // Pink 700 Navbar
//         centerTitle: true,
//       ),
//       body: BlocBuilder<CourseBloc, CourseState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Text(
//                 'Error: ${state.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           } else if (state.selectedCourse == null) {
//             return const Center(child: Text('No Course Details Available'));
//           }

//           final course = state.selectedCourse!;
//           String fullImageUrl =
//               (course.courseImage != null && course.courseImage!.isNotEmpty)
//                   ? "${widget.baseUrl}${course.courseImage}"
//                   : "https://via.placeholder.com/150";

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ✅ Course Image
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       fullImageUrl,
//                       height: 180,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         height: 180,
//                         color: Colors.grey[300],
//                         child: const Center(
//                           child: Icon(Icons.image_not_supported,
//                               size: 50, color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // ✅ Course Name & Instructor
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           course.courseName,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.person,
//                               color: Color.fromARGB(255, 22, 5, 149)),
//                           const SizedBox(width: 5),
//                           Text(
//                             course.instructor,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 10),

//                   // ✅ Address 📍
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on,
//                           color: Color.fromARGB(255, 205, 137, 69)),
//                       const SizedBox(width: 5),
//                       const Text(
//                         "Maitidevi, Kathmandu",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 12),

//                   // ✅ Course Details Section (Horizontal List)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildDetailCard(Icons.category, "Category", "Course"),
//                       _buildDetailCard(
//                           Icons.access_time, "Duration", course.duration),
//                       _buildDetailCard(Icons.attach_money, "Price",
//                           "Rs. ${course.coursePrice}"),
//                     ],
//                   ),

//                   const SizedBox(height: 15),

//                   // ✅ Description Section with "Read More"
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Description",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         isExpanded
//                             ? course.courseDescription
//                             : course.courseDescription.length > 100
//                                 ? "${course.courseDescription.substring(0, 100)}..."
//                                 : course.courseDescription,
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.black87),
//                       ),
//                       if (course.courseDescription.length > 100)
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               isExpanded = !isExpanded;
//                             });
//                           },
//                           child: Text(
//                             isExpanded ? "Read Less" : "Read More",
//                             style: TextStyle(
//                                 color: Colors.pink.shade700,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                     ],
//                   ),

//                   const SizedBox(height: 2),

//                   // ✅ "Book Now" Button (Pink 700 & Smaller Width)
//                   Center(
//                     child: SizedBox(
//                       width: 250, // Reduced width
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BlocProvider(
//                                 create: (context) => BookingBloc(
//                                   createBookingUsecase:
//                                       GetIt.instance<CreateBookingUsecase>(),
//                                   paymentBloc: getIt(),
//                                 ),
//                                 child: BookingFormView(),
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15), // Smaller height
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           backgroundColor: Colors.pink.shade700,
//                           elevation: 5,
//                         ),
//                         child: const Text(
//                           "Book Now",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ✅ Helper method to create small detail cards
//   Widget _buildDetailCard(IconData icon, String title, String value) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 28, color: Colors.pinkAccent),
//             const SizedBox(height: 5),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               value,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
import 'package:get_it/get_it.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

class CourseDetailView extends StatefulWidget {
  final String courseId;
  final String baseUrl = "http://10.0.2.2:9000/";

  const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseDetailViewState createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  bool isExpanded = false;
  StreamSubscription? _accelerometerSubscription;
  double _lastX = 0;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _startListeningToSensor();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _startListeningToSensor() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double x = event.x;

      // Detect significant tilt change (Threshold: ±7 for rapid movement)
      if ((x - _lastX).abs() > 7 && !_isRefreshing) {
        _isRefreshing = true;
        _refreshCourseDetails();
      }

      _lastX = x;
    });
  }

  void _refreshCourseDetails() {
    setState(() {
      context.read<CourseBloc>().add(CourseDetailLoad(widget.courseId));
    });

    // Prevent multiple refreshes within 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<CourseBloc>().add(CourseDetailLoad(widget.courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Details"),
        backgroundColor: Colors.pink.shade700,
        centerTitle: true,
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.selectedCourse == null) {
            return const Center(child: Text('No Course Details Available'));
          }

          final course = state.selectedCourse!;
          String fullImageUrl =
              (course.courseImage != null && course.courseImage!.isNotEmpty)
                  ? "${widget.baseUrl}${course.courseImage}"
                  : "https://via.placeholder.com/150";

          return RefreshIndicator(
            onRefresh: () async {
              _refreshCourseDetails();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        fullImageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 180,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                size: 50, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            course.courseName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person,
                                color: Color.fromARGB(255, 22, 5, 149)),
                            const SizedBox(width: 5),
                            Text(
                              course.instructor,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Color.fromARGB(255, 205, 137, 69)),
                        const SizedBox(width: 5),
                        const Text(
                          "Maitidevi, Kathmandu",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailCard(Icons.category, "Category", "Course"),
                        _buildDetailCard(
                            Icons.access_time, "Duration", course.duration),
                        _buildDetailCard(Icons.attach_money, "Price",
                            "Rs. ${course.coursePrice}"),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          isExpanded
                              ? course.courseDescription
                              : course.courseDescription.length > 100
                                  ? "${course.courseDescription.substring(0, 100)}..."
                                  : course.courseDescription,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                        if (course.courseDescription.length > 100)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Read Less" : "Read More",
                              style: TextStyle(
                                  color: Colors.pink.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Center(
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => BookingBloc(
                                    createBookingUsecase:
                                        GetIt.instance<CreateBookingUsecase>(),
                                    paymentBloc: getIt(),
                                  ),
                                  child: BookingFormView(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.pink.shade700,
                            elevation: 5,
                          ),
                          child: const Text(
                            "Book Now",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildDetailCard(IconData icon, String title, String value) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.pinkAccent),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
