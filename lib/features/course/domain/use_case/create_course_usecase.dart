import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

class CreateCourseParams extends Equatable {
  final String courseName;
  final double coursePrice;
  final String instructor;
  final String courseImage;
  final String duration;

  const CreateCourseParams({
    required this.courseName,
    required this.coursePrice,
    required this.instructor,
    required this.courseImage,
    required this.duration,
  });

  const CreateCourseParams.empty()
      : courseName = '_empty.string',
        coursePrice = 0.0,
        instructor = '',
        courseImage = '',
        duration = '';

  @override
  List<Object?> get props => [courseName, coursePrice, instructor, courseImage, duration];
}

class CreateCourseUsecase implements UsecaseWithParams<void, CreateCourseParams> {
  final ICourseRepository courseRepository;

  CreateCourseUsecase({required this.courseRepository});

  @override
  Future<Either<Failure, void>> call(CreateCourseParams params) async {
    return await courseRepository.createCourse(CourseEntity(
      courseName: params.courseName,
      coursePrice: params.coursePrice,
      instructor: params.instructor,
      courseImage: params.courseImage,
      duration: params.duration,
    ));
  }
}
