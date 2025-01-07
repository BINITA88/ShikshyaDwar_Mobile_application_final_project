
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
      // convert batchenetity to batchModel
      final courseHiveModel = CourseHiveModel.fromEntity(courseEntity);
      await _hiveService.addCourse((courseHiveModel));
    } catch (e) {
      throw Exception(e);
    }

    
  }


  @override
  Future<void> deleteCourse(String id) async {
    try {
      // convert batchenetity to batchModel
      return await _hiveService.deleteCourse((id));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getAllCourses() {
    try {
      // convert batch entity to batchModel
      return _hiveService.getAllCourses().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }


}
