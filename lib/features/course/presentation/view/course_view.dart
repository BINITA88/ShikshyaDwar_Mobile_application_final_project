import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/getAll_course_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/widget/course_card.dart';

import '../view_model/course_bloc.dart';

class CourseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseBloc(
        getAllCourseUsecase: context.read<GetAllCourseUsecase>(),
      )..add(LoadCoursesEvent()), // Load courses on screen open
      child: Scaffold(
        appBar: AppBar(title: Text("Available Courses")),
        body: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator()); // Show loading
            } else if (state.courses.isEmpty) {
              return Center(child: Text("No courses available.")); // No data
            } else {
              return ListView.builder(
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  final course = state.courses[index];
                  return CourseCard(course: course); // Custom course card
                },
              );
            }
          },
        ),
      ),
    );
  }
}
