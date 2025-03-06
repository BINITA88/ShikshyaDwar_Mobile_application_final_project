import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDataSource _courseRemoteDataSource;

  CourseRemoteRepository(this._courseRemoteDataSource);

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      // ✅ Fetch courses from API
      final courses = await _courseRemoteDataSource.getCourses();
      return Right(courses);
    } on SocketException {
      return Left(ApiFailure(message: "No Internet Connection"));
    } catch (e) {
      return Left(ApiFailure(message: "API Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseDetail(String courseId) async {
    try {
      final courseData =
          await _courseRemoteDataSource.getCourseDetailsById(courseId);
      return Right(courseData);
    } on SocketException {
      return Left(ApiFailure(message: "No Internet Connection"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
