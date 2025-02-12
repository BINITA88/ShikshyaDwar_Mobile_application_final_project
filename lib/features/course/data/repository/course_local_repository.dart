import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalDataSource _courseLocalDataSource;

  CourseLocalRepository({required CourseLocalDataSource courseLocalDataSource})
      : _courseLocalDataSource = courseLocalDataSource;





  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() {
    try {
      return _courseLocalDataSource.getCourses().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
  
  @override
  Future<Either<Failure, CourseEntity>> getCourseDetail(String courseId) {
    // TODO: implement getCourseDetail
    throw UnimplementedError();
  }


}
