
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseDataSource {
  Future<void> createCourse(CourseEntity courseEntity);
  Future<void> updateCourse(CourseEntity courseEntity);

  Future<List<CourseEntity>> getAllCourses();

  Future<void> deleteCourse(String id);

// searchByID ene hru thapyo vane sab ma milaune jate ota xa tate ota rakhne
}
