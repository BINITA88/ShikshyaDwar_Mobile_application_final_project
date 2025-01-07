
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/student_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/auth_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/student_entity.dart';

class LocalDataSource implements IStudentDataSource {
  final HiveService _hiveService;

  LocalDataSource(this._hiveService);

  @override
  Future<void> createStudent(StudentEntity studentEntity) async {
    try {
      // convert batch entity to batchModel
      final authHiveModel = AuthHiveModel.fromEntity(studentEntity);
      await _hiveService.addStudent((authHiveModel));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteStudents(String id) async {
    try {
      // convert batchenetity to batchModel
      return await _hiveService.deleteStudent((id));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<StudentEntity>> getAllStudents() {
    try {
      // convert batch entity to batchModel
      return _hiveService.getAllStudent().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthHiveModel?> login(String username, String password) {
    try {
      // convert student entity to batchModel
      return _hiveService.login(username, password);
    } catch (e) {
      throw Exception(e);
    }
  }


}
