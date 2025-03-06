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

// import 'package:dartz/dartz.dart';
// import 'package:shikshyadwar_mobile_application_project/core/common/internet_checker/internet_checker.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

// class CourseLocalRepository implements ICourseRepository {
//   final CourseLocalDataSource _courseLocalDataSource;
//   final CourseRemoteDataSource _courseRemoteDataSource;
//   final NetworkInfo _networkInfo;

//   CourseLocalRepository({
//     required CourseLocalDataSource courseLocalDataSource,
//     required CourseRemoteDataSource courseRemoteDataSource,
//     required NetworkInfo networkInfo,
//   })  : _courseLocalDataSource = courseLocalDataSource,
//         _courseRemoteDataSource = courseRemoteDataSource,
//         _networkInfo = networkInfo;

//   @override
//   Future<Either<Failure, List<CourseEntity>>> getCourses() async {
//     if (await _networkInfo.isConnected) {
//       try {
//         // ✅ Fetch courses from API
//         final courses = await _courseRemoteDataSource.getCourses();

//         // ✅ Store in Hive for offline use
//         await _courseLocalDataSource.cacheCourses(courses);

//         return Right(courses);
//       } catch (e) {
//         print("❌ API Error: ${e.toString()} - Trying Hive Cache...");
//       }
//     }


//     try {
//       // ✅ Fetch from Hive if API fails or offline
//       final localCourses = await _courseLocalDataSource.getCourses();
//       print("✅ Loaded ${localCourses.length} courses from Hive.");
//       return Right(localCourses);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(
//           message: "Local Database Error: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, CourseEntity>> getCourseDetail(String courseId) async {
//     //  TODO: implement getCourseDetail
//     throw UnimplementedError();
//   }
// }


