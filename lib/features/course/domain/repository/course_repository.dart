import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseRepository {
  Future<Either<Failure, void>> createCourse(CourseEntity courseEntity);
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
  Future<Either<Failure, void>> deleteCourses(String id);
}
