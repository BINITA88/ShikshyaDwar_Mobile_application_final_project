import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';


class StudentEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final BatchEntity batch;
  final List <CourseEntity> courses;
    final String username;
      final String password;

 const StudentEntity( {
  this.id,
  required this.lname,
   this.image, required this.phone,required this.batch, required this.courses, required this.username, required this.password, required this.fname,
 
 }) ;



  @override
  // TODO: implement props
  List<Object?> get props => [id,username];
}
