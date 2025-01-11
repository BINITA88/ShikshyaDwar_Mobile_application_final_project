import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateCourseParams extends Equatable {
  final String courseId; // ID is required for updating
  final String courseName;
  final double coursePrice;
  final String instructor;
  final String courseImage;
  final String duration;

  const UpdateCourseParams({
    required this.courseId,
    required this.courseName,
    required this.coursePrice,
    required this.instructor,
    required this.courseImage,
    required this.duration,
  });

  @override
  List<Object?> get props =>
      [courseId, courseName, coursePrice, instructor, courseImage, duration];
}

class UpdateCourseUsecase {
  final ICourseRepository courseRepository;

  UpdateCourseUsecase({required this.courseRepository});

  Future<Either<Failure, void>> call(UpdateCourseParams params) async {
    return await courseRepository.updateCourse(CourseEntity(
      courseId: params.courseId,
      courseName: params.courseName,
      coursePrice: params.coursePrice,
      instructor: params.instructor,
      courseImage: params.courseImage,
      duration: params.duration,
    ));
  }
}
