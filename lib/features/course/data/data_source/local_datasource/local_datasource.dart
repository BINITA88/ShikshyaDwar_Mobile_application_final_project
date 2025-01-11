import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/course_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

abstract class LocalDatasource implements ICourseDataSource {
  final HiveService _hiveService;

  LocalDatasource(this._hiveService);

  @override
  Future<void> createCourse(CourseEntity courseEntity) async {
    try {
      // Convert courseEntity to CourseHiveModel
      final courseHiveModel = CourseHiveModel.fromEntity(courseEntity);
      await _hiveService.addCourse(courseHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      // Delete course using courseId
      return await _hiveService.deleteCourse(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getAllCourses() async {
    try {
      // Retrieve all courses and convert them to CourseEntity
      return _hiveService.getAllCourses().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  // Add updateCourse method
  @override
  Future<void> updateCourse(CourseEntity courseEntity) async {
    try {
      // Convert courseEntity to CourseHiveModel
      final courseHiveModel = CourseHiveModel.fromEntity(courseEntity);
      await _hiveService
          .updateCourse(courseHiveModel); // Call updateCourse in HiveService
    } catch (e) {
      throw Exception(e);
    }
  }
}
