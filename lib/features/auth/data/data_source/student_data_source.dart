
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentDataSource {
  Future<void> createStudent(StudentEntity studentEntity);

  Future<List<StudentEntity>> getAllStudents();

  Future<void> deleteStudents(String id);

  Future<void> login(String username ,String password);

// searchByID ene hru thapyo vane sab ma milaune jate ota xa tate ota rakhne
}
