// import 'package:dartz/dartz.dart';
// import 'package:shikshyadwar_mobile_application_project/core/common/internet_checker/internet_checker.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

// class CourseRepositoryImpl implements ICourseRepository {
//   final CourseLocalDataSource _courseLocalDataSource;
//   final CourseRemoteDataSource _courseRemoteDataSource;
//   final NetworkInfo _networkInfo;

//   CourseRepositoryImpl({
//     required CourseLocalDataSource courseLocalDataSource,
//     required CourseRemoteDataSource courseRemoteDataSource,
//     required NetworkInfo networkInfo,
//   })  : _courseLocalDataSource = courseLocalDataSource,
//         _courseRemoteDataSource = courseRemoteDataSource,
//         _networkInfo = networkInfo;

//   // @override
//   // Future<Either<Failure, List<CourseEntity>>> getCourses() async {
//   //   if (await _networkInfo.isConnected) {
//   //     try {
//   //       final courses = await _courseRemoteDataSource.getCourses();
//   //       await _courseLocalDataSource.cacheCourses(courses);
//   //       return Right(courses);
//   //     } catch (e) {
//   //       print("❌ API Error: ${e.toString()} - Fetching from Hive...");
//   //     }
//   //   }

//   //   try {
//   //     final localCourses = await _courseLocalDataSource.getCourses();
//   //     return Right(localCourses);
//   //   } catch (e) {
//   //     return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
//   //   }
//   // }

//   @override
//   Future<Either<Failure, List<CourseEntity>>> getCourses() async {
//     bool isOnline = await _networkInfo.isConnected;
//     print("🌍 Network Status: $isOnline"); // ✅ Debugging log

//     if (isOnline) {
//       try {
//         final courses = await _courseRemoteDataSource.getCourses();
//         print(
//             "✅ Fetched ${courses.length} courses from API."); // ✅ Debugging log

//         // ✅ Cache the courses locally
//         await _courseLocalDataSource.cacheCourses(courses);

//         return Right(courses);
//       } catch (e) {
//         print("❌ API Fetch Error: ${e.toString()}");
//       }
//     }

//     try {
//       final localCourses = await _courseLocalDataSource.getCourses();
//       print(
//           "✅ Loaded ${localCourses.length} courses from Hive."); // ✅ Debugging log
//       return Right(localCourses);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, CourseEntity>> getCourseDetail(String courseId) {
//     // TODO: implement getCourseDetail
//     throw UnimplementedError();
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements ICourseRepository {
  final CourseLocalDataSource _courseLocalDataSource;
  final CourseRemoteDataSource _courseRemoteDataSource;
  final NetworkInfo _networkInfo;

  CourseRepositoryImpl({
    required CourseLocalDataSource courseLocalDataSource,
    required CourseRemoteDataSource courseRemoteDataSource,
    required NetworkInfo networkInfo,
  })  : _courseLocalDataSource = courseLocalDataSource,
        _courseRemoteDataSource = courseRemoteDataSource,
        _networkInfo = networkInfo;
  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    bool isOnline = await _networkInfo.isConnected;
    print("🌍 Network Status: $isOnline");

    if (isOnline) {
      try {
        final courses = await _courseRemoteDataSource.getCourses();
        print("✅ API Returned ${courses.length} courses.");

        if (courses.isNotEmpty) {
          await _courseLocalDataSource.cacheCourses(courses); // ✅ Store in Hive
          print("📂 Courses stored in Hive.");
        } else {
          print("⚠️ No courses received from API, not storing in Hive.");
        }

        return Right(courses);
      } catch (e) {
        print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
      }
    }

    // ✅ If offline or API fails, load from Hive
    try {
      final localCourses = await _courseLocalDataSource.getCourses();
      print("📂 Hive Loaded ${localCourses.length} courses.");
      return Right(localCourses);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseDetail(String courseId) async {
    bool isOnline = await _networkInfo.isConnected;
    print("🌍 Network Status: $isOnline");

    if (isOnline) {
      try {
        final course =
            await _courseRemoteDataSource.getCourseDetailsById(courseId);
        print("✅ API Course Retrieved: ${course.courseName}");

        await _courseLocalDataSource.cacheCourses([course]); // Store in Hive
        return Right(course);
      } catch (e) {
        print("❌ API Fetch Error: ${e.toString()} - Fetching from Hive...");
      }
    }

    // If offline or API fails, load from Hive
    try {
      final localCourses = await _courseLocalDataSource.getCourses();
      final course = localCourses.firstWhere((c) => c.courseId == courseId,
          orElse: () => throw Exception("Course Not Found"));
      print("📂 Hive Loaded Course: ${course.courseName}");
      return Right(course);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Hive Error: ${e.toString()}"));
    }
  }
}
