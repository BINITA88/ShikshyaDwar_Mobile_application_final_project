import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

class DeleteCourseParams {
  final String courseId;
  const DeleteCourseParams({required this.courseId});

  const DeleteCourseParams.empty() : courseId = '_empty.string';
}

class DeleteCourseUsecase
    implements UsecaseWithParams<void, DeleteCourseParams> {
  final ICourseRepository courseRepository;

  DeleteCourseUsecase({required this.courseRepository});

  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) {
    return courseRepository.deleteCourses(params.courseId);
  }
}
