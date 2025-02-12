import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view/course_detail_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

class CourseView extends StatelessWidget {
  final String baseUrl = "http://10.0.2.2:9000/public/uploads/";

  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CourseBloc>()..add(CourseLoad()), // ✅ Ensure Bloc is Provided
      child: Scaffold(
        appBar: AppBar(title: const Text("Course View")),
        body: BlocBuilder<CourseBloc, CourseState>(
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
              return const Center(child: Text('No Courses Added Yet'));
            } else {
              return ListView.builder(
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  final course = state.courses[index];

                  // ✅ Ensure proper URL formation for images (handle null)
                  String fullImageUrl = (course.courseImage?.isNotEmpty == true)
                      ? "$baseUrl${course.courseImage}"
                      : "";

                  return Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Text(
                        course.courseName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Instructor: ${course.instructor}"),
                      leading: fullImageUrl.isNotEmpty
                          ? Image.network(
                              fullImageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            )
                          : const Icon(Icons.book, size: 50), // ✅ Fallback icon
                      onTap: () {
                        final courseBloc = context.read<
                            CourseBloc>(); // Ensure Bloc instance is available

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value:
                                  courseBloc, // ✅ Safely pass the existing Bloc instance
                              child: CourseDetailView(
                                  courseId: course.courseId ?? ''),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
