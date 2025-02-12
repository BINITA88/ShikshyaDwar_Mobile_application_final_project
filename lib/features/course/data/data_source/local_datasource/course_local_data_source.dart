
import 'dart:io';

import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/course_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class CourseLocalDataSource implements ICourseDataSource {
  final HiveService _hiveService;

  CourseLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;


  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      final courseHiveModelList = await _hiveService.getAllCourses();
      return CourseHiveModel.toEntityList(courseHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
  
  @override
  Future<CourseEntity> getCourseDetailsById(String courseId) {
    // TODO: implement getCourseDetailsById
    throw UnimplementedError();
  }

}
