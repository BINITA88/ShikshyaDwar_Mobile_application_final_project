import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

class GetCourseDetailUseCase
    implements UsecaseWithParams<CourseEntity, String> {
  final ICourseRepository _courseRepository;

  GetCourseDetailUseCase({required ICourseRepository courseRepository})
      : _courseRepository = courseRepository;

  @override
  Future<Either<Failure, CourseEntity>> call(String courseId) {
    return _courseRepository.getCourseDetail(courseId);
  }
}
