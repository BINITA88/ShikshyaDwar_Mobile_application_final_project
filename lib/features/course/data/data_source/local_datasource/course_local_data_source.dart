// import 'dart:io';

// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/course_data_source.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

// class CourseLocalDataSource implements ICourseDataSource {
//   final HiveService _hiveService;

//   CourseLocalDataSource({required HiveService hiveService})
//       : _hiveService = hiveService;

//   @override
//   Future<List<CourseEntity>> getCourses() async {
//     try {
//       final courseHiveModelList = await _hiveService.getAllCourses();
//       return CourseHiveModel.toEntityList(courseHiveModelList);
//     } catch (e) {
//       throw LocalDatabaseFailure(message: e.toString());
//     }
//   }

//   @override
//   Future<CourseEntity> getCourseDetailsById(String courseId) {
//     // TODO: implement getCourseDetailsById
//     throw UnimplementedError();
//   }

// }

// import 'package:hive_flutter/adapters.dart';
// import 'package:shikshyadwar_mobile_application_project/core/common/internet_checker/internet_checker.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';

// class CourseLocalDataSource {
//   final HiveService _hiveService;
//   final NetworkInfo _networkInfo;

//   CourseLocalDataSource({
//     required HiveService hiveService,
//     required NetworkInfo networkInfo,
//   })  : _hiveService = hiveService,
//         _networkInfo = networkInfo;

//   Future<List<CourseEntity>> getCourses() async {
//     try {
//       var box = await Hive.openBox<CourseHiveModel>('coursesBox');
//       final courses = box.values.toList();

//       print("✅ Retrieved ${courses.length} courses from Hive.");
//       return CourseHiveModel.toEntityList(courses);
//     } catch (e) {
//       print("❌ Failed to retrieve courses from Hive: ${e.toString()}");
//       throw LocalDatabaseFailure(message: e.toString());
//     }
//   }

//   Future<void> cacheCourses(List<CourseEntity> courses) async {
//     try {
//       final courseModels = CourseHiveModel.fromEntityList(courses);
//       var box = await Hive.openBox<CourseHiveModel>('coursesBox');

//       for (var course in courseModels) {
//         await box.put(course.courseId, course); // ✅ Store each course in Hive
//         print("✅ Cached Course: ${course.courseName}");
//       }
//       print("✅ Total Cached Courses: ${box.length}");
//     } catch (e) {
//       print("❌ Failed to cache courses: ${e.toString()}");
//     }
//   }
// }

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class CourseLocalDataSource {
  final HiveService _hiveService;
  final NetworkInfo _networkInfo;

  CourseLocalDataSource({
    required HiveService hiveService,
    required NetworkInfo networkInfo,
  })  : _hiveService = hiveService,
        _networkInfo = networkInfo;

  Future<List<CourseEntity>> getCourses() async {
    try {
      var box = Hive.box<CourseHiveModel>('coursesBox');
      final courses = box.values.toList();
      print("📂 Hive Retrieved ${courses.length} courses."); // ✅ Debugging log

      for (var course in courses) {
        print(
            "📂 Course Loaded: ${course.courseName} (ID: ${course.courseId})");
      }

      return CourseHiveModel.toEntityList(courses);
    } catch (e) {
      print("❌ Failed to retrieve courses from Hive: ${e.toString()}");
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  Future<void> cacheCourses(List<CourseEntity> courses) async {
    try {
      final courseModels = CourseHiveModel.fromEntityList(courses);
      var box = await Hive.openBox<CourseHiveModel>('coursesBox');

      await box.clear(); // ✅ Clear old courses before storing new ones

      for (var course in courseModels) {
        await box.put(course.courseId, course);
        print(
            "✅ Cached Course: ${course.courseName} (ID: ${course.courseId})"); // ✅ Debugging log
      }
      print("✅ Total Cached Courses: ${box.length} in Hive.");
    } catch (e) {
      print("❌ Failed to cache courses: ${e.toString()}");
    }
  }
}













// import 'package:hive/hive.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';

// class CourseLocalDataSource {
//   final String boxName = 'courseBox';
//   Box<CourseHiveModel>? _box;

//   // ✅ Initialize Hive Box (To avoid opening multiple times)
//   Future<void> _initBox() async {
//     _box ??= await Hive.openBox<CourseHiveModel>(boxName);
//   }

//   // ✅ Save Courses to Hive
//   Future<void> cacheCourses(List<CourseHiveModel> courses) async {
//     await _initBox(); // Ensure box is initialized

//     if (courses.isEmpty) {
//       print("⚠️ No courses to cache.");
//       return;
//     }

//     for (var course in courses) {
//       if (course.courseId != null) {
//         await _box!.put(course.courseId, course);
//         print("✅ Cached Course: ${course.courseName}");
//       } else {
//         print("⚠️ Skipped course with null ID: ${course.courseName}");
//       }
//     }

//     print("✅ Total Cached Courses: ${_box!.length}");
//   }

//   // ✅ Retrieve Courses from Hive
//   Future<List<CourseHiveModel>> getCoursesFromCache() async {
//     await _initBox(); // Ensure box is initialized

//     if (_box!.isEmpty) {
//       print("⚠️ No cached courses found.");
//       return [];
//     }

//     print("✅ Retrieved ${_box!.length} courses from Hive.");
//     return _box!.values.toList();
//   }
// }







// hive try


// import 'package:hive_flutter/adapters.dart';
// import 'package:shikshyadwar_mobile_application_project/core/common/internet_checker/internet_checker.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

// class CourseLocalDataSource {
//   final Box<CourseHiveModel> _box;
//   final NetworkInfo _networkInfo;

//   CourseLocalDataSource({
//     required Box<CourseHiveModel> box,
//     required NetworkInfo networkInfo, required HiveService hiveService,
//   })  : _box = box,
//         _networkInfo = networkInfo;

//   Future<List<CourseEntity>> getCourses() async {
//     try {
//       final courses = _box.values.toList();
//       print("✅ Retrieved ${courses.length} courses from Hive.");
//       return CourseHiveModel.toEntityList(courses);
//     } catch (e) {
//       print("❌ Failed to retrieve courses from Hive: ${e.toString()}");
//       throw LocalDatabaseFailure(message: e.toString());
//     }
//   }

//   Future<void> cacheCourses(List<CourseEntity> courses) async {
//     try {
//       final courseModels = CourseHiveModel.fromEntityList(courses);
//       await _box.clear(); // ✅ Clear old data before caching new data
//       for (var course in courseModels) {
//         await _box.put(course.courseId, course);
//         print("✅ Cached Course: ${course.courseName}");
//       }
//       print("✅ Total Cached Courses: ${_box.length}");
//     } catch (e) {
//       print("❌ Failed to cache courses: ${e.toString()}");
//     }
//   }
// }