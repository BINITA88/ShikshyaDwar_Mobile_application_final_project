import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view/booking_form_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

class CourseDetailView extends StatelessWidget {
  final String courseId;
  final String baseUrl = "http://10.0.2.2:9000/";

  const CourseDetailView({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch course details when the view is opened
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

          // ✅ Ensure correct image URL
          String fullImageUrl =
              (course.courseImage != null && course.courseImage!.isNotEmpty)
                  ? "$baseUrl${course.courseImage}"
                  : "https://via.placeholder.com/150"; // Fallback image

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Course Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      fullImageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Course Name
                  Text(
                    course.courseName,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Instructor Name
                  Text(
                    "Instructor: ${course.instructor}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Course Price
                  Text(
                    "Price: Rs.${course.coursePrice}",
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  Text(
                    "Category: Course",
                    style: const TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 12, 12, 12)),
                  ),
                  Text(
                    "Duration: ${course.duration}",
                    style: const TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 221, 116, 5)),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Course Description
                  Text(
                    "Description:",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),
                  Text(
                    course.courseDescription,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  // ✅ "Book Now" Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => BookingBloc(
                                createBookingUsecase: GetIt.instance<
                                    CreateBookingUsecase>(), paymentBloc: getIt(), // ✅ Correctly provide use case
                              ),
                              child: BookingFormView(),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Book Now",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
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
