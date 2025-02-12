import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

class CourseDetailView extends StatelessWidget {
  final String courseId;
  final String baseUrl = "http://10.0.2.2:9000/public/uploads/";

  const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch course details when view is opened
    context.read<CourseBloc>().add(CourseDetailLoad(courseId));

    return Scaffold(
      appBar: AppBar(title: const Text("Course Details")),
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

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  course.courseImage != null && course.courseImage!.isNotEmpty
                      ? Image.network(
                          "$baseUrl${course.courseImage}",
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.image, size: 100),
                  const SizedBox(height: 10),
                  Text(
                    course.courseName,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Instructor: ${course.instructor}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Price: \$${course.coursePrice}",
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Category: ${course.category ?? 'Unknown'}",
                    style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description:",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    course.courseDescription,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
