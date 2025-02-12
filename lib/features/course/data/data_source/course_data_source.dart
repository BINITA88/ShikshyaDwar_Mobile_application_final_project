// import 'dart:io';

// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

// abstract interface class ICourseDataSource {
//   Future<List<CourseEntity>> getCourses();

// }
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

abstract class ICourseDataSource {
  Future<List<CourseEntity>> getCourses();
  Future<CourseEntity> getCourseDetailsById(String courseId); // Added method
}
