// import 'package:flutter/material.dart';

// class CourseView extends StatelessWidget {
//   const CourseView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Sample course data
//     final List<Map<String, String>> courses = [
//       {
//         "image": "assets/images/reading.png",
//         "title": "IELTS Reading",
//         "date": "Jan 15, 2024",
//         "duration": "6 Weeks"
//       },
//       {
//         "image": "assets/images/pte.png",
//         "title": "IELTS Writing",
//         "date": "Feb 1, 2024",
//         "duration": "8 Weeks"
//       },
//       {
//         "image": "assets/images/speaking.png",
//         "title": "IELTS Speaking",
//         "date": "Mar 1, 2024",
//         "duration": "4 Weeks"
//       },
//       {
//         "image": "assets/images/listening.png",
//         "title": "IELTS Listening",
//         "date": "Apr 1, 2024",
//         "duration": "4 Weeks"
//       },
//     ];

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Search Bar
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search courses...',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Active Courses Section
//               const Text(
//                 "Active Courses",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 220,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 2, // Show only first 2 courses as active
//                   itemBuilder: (context, index) {
//                     var course = courses[index];
//                     return MyCart(
//                       image: course["image"]!,
//                       title: course["title"]!,
//                       date: course["date"]!,
//                       duration: course["duration"]!,
//                       onPressed: () {
//                         // Handle course selection
//                       },
//                     );
//                   },
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Available Courses Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Available Courses",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Handle view all
//                     },
//                     child: const Text("View All"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 220,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: courses.length,
//                   itemBuilder: (context, index) {
//                     var course = courses[index];
//                     return MyCart(
//                       image: course["image"]!,
//                       title: course["title"]!,
//                       date: course["date"]!,
//                       duration: course["duration"]!,
//                       onPressed: () {
//                         // Handle course selection
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // MyCart widget (in case you need it)
// class MyCart extends StatelessWidget {
//   final String image;
//   final String title;
//   final String date;
//   final String duration;
//   final VoidCallback onPressed;

//   const MyCart({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.date,
//     required this.duration,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       margin: const EdgeInsets.only(right: 16),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(12)),
//               child: Image.asset(
//                 image,
//                 height: 100,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Starts: $date',
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                   Text(
//                     'Duration: $duration',
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';

// class CourseView extends StatelessWidget {
//   CourseView({super.key});

//   final courseNameController = TextEditingController();
//   final coursePriceController = TextEditingController();
//   final instructorController = TextEditingController();
//   final courseImageController = TextEditingController();
//   final durationController = TextEditingController();
//   final categoryController = TextEditingController();
//   final courseDescriptionController = TextEditingController();

//   final _courseViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _courseViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: courseNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Course Name',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: coursePriceController,
//                 decoration: const InputDecoration(
//                   labelText: 'Course Price',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course price';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid price';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: instructorController,
//                 decoration: const InputDecoration(
//                   labelText: 'Instructor',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter instructor name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: courseImageController,
//                 decoration: const InputDecoration(
//                   labelText: 'Course Image URL',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course image URL';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: durationController,
//                 decoration: const InputDecoration(
//                   labelText: 'Duration',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course duration';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(
//                   labelText: 'Category',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course category';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: courseDescriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Course Description',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.all(12.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter course description';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_courseViewFormKey.currentState!.validate()) {
//                     context.read<CourseBloc>().add(
//                           CreateCourse(
//                             courseName: courseNameController.text,
//                             coursePrice:
//                                 double.parse(coursePriceController.text),
//                             instructor: instructorController.text,
//                             courseImage: courseImageController.text,
//                             duration: durationController.text,
//                             category: categoryController.text,
//                             courseDescription: courseDescriptionController.text,
//                           ),
//                         );
//                     courseNameController.clear(); // Clear input after adding
//                     coursePriceController.clear();
//                     instructorController.clear();
//                     courseImageController.clear();
//                     durationController.clear();
//                     categoryController.clear();
//                     courseDescriptionController.clear();
//                   }
//                 },
//                 child: Text('Add Course'),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: BlocBuilder<CourseBloc, CourseState>(
//                   builder: (context, state) {
//                     if (state.isLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state.courses.isEmpty) {
//                       return Center(child: Text('No Courses Added Yet'));
//                     } else {
//                       return ListView.builder(
//                         itemCount: state.courses.length,
//                         itemBuilder: (context, index) {
//                           final course = state.courses[index];
//                           return Card(
//                             elevation: 3,
//                             margin: EdgeInsets.symmetric(vertical: 5),
//                             child: ListTile(
//                               title: Text(course.courseName),
//                               subtitle: Text("ID: ${course.courseId}"),
//                               trailing: IconButton(
//                                 icon: Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   context.read<CourseBloc>().add(
//                                         DeleteCourse(id: course.courseId!),
//                                       );
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
