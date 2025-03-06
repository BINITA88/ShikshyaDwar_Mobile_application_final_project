// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:uuid/uuid.dart';

// import '../../../../app/constants/hive_table_constant.dart';

// part 'course_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.courseTableId)
// @JsonSerializable()
// class CourseHiveModel extends Equatable {
//   @HiveField(0)
//   final String? courseId;

//   @HiveField(1)
//   final String courseName;

//   @HiveField(2)
//   final num coursePrice;

//   @HiveField(3)
//   final String instructor;

//   @HiveField(4)
//   final String? courseImage;

//   @HiveField(5)
//   final String duration;

//   @HiveField(6)
//   final String? category; // Assuming category is a String

//   @HiveField(7)
//   final String courseDescription;

//   CourseHiveModel({
//     String? courseId,
//     required this.courseName,
//     required this.coursePrice,
//     required this.instructor,
//      this.courseImage,
//     required this.duration,
//      this.category,
//     required this.courseDescription,
//   }) : courseId = courseId ?? const Uuid().v4();

//   const CourseHiveModel.initial()
//       : courseId = '',
//         courseName = '',
//         coursePrice = 0,
//         instructor = '',
//         courseImage = '',
//         duration = '',
//         category = '',
//         courseDescription = '';
// // FROM ENTITY
//   factory CourseHiveModel.fromEntity(CourseEntity entity) {
//     return CourseHiveModel(
//       courseId: entity.courseId,
//       courseName: entity.courseName,
//       coursePrice: entity.coursePrice,
//       instructor: entity.instructor,
//       courseImage: entity.courseImage,
//       duration: entity.duration,
//       category: entity.category,
//       courseDescription: entity.courseDescription,
//     );
//   }
// // TO ENTITY
//   CourseEntity toEntity() {
//     return CourseEntity(
//       courseId: courseId,
//       courseName: courseName,
//       coursePrice: coursePrice,
//       instructor: instructor,
//       courseImage: courseImage,
//       duration: duration,
//       category: category,
//       courseDescription: courseDescription,
//     );
//   }

//   static List<CourseHiveModel> fromEntityList(List<CourseEntity> entities) {
//     return entities.map((e) => CourseHiveModel.fromEntity(e)).toList();
//   }

//   static List<CourseEntity> toEntityList(List<CourseHiveModel> entities) {
//     return entities.map((e) => e.toEntity()).toList();
//   }

//   @override
//   List<Object?> get props => [
//         courseId,
//         courseName,
//         coursePrice,
//         instructor,
//         courseImage,
//         duration,
//         category,
//         courseDescription,
//       ];
// }

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
@JsonSerializable() // ✅ Enables JSON serialization
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String? courseId;

  @HiveField(1)
  final String courseName;

  @HiveField(2)
  final num coursePrice;

  @HiveField(3)
  final String instructor;

  @HiveField(4)
  final String? courseImage;

  @HiveField(5)
  final String duration;

  @HiveField(6)
  final String? category;

  @HiveField(7)
  final String courseDescription;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
    required this.coursePrice,
    required this.instructor,
    this.courseImage,
    required this.duration,
    this.category,
    required this.courseDescription,
  }) : courseId = courseId ?? const Uuid().v4();

  const CourseHiveModel.initial()
      : courseId = '',
        courseName = '',
        coursePrice = 0,
        instructor = '',
        courseImage = '',
        duration = '',
        category = '',
        courseDescription = '';

  // ✅ FROM ENTITY
  factory CourseHiveModel.fromEntity(CourseEntity entity) {
    return CourseHiveModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
      coursePrice: entity.coursePrice,
      instructor: entity.instructor,
      courseImage: entity.courseImage,
      duration: entity.duration,
      category: entity.category,
      courseDescription: entity.courseDescription,
    );
  }

  // ✅ TO ENTITY
  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      courseName: courseName,
      coursePrice: coursePrice,
      instructor: instructor,
      courseImage: courseImage,
      duration: duration,
      category: category,
      courseDescription: courseDescription,
    );
  }

  static List<CourseHiveModel> fromEntityList(List<CourseEntity> entities) {
    return entities.map((e) => CourseHiveModel.fromEntity(e)).toList();
  }

  static List<CourseEntity> toEntityList(List<CourseHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  // ✅ FROM JSON (API Response to Hive Model)
  factory CourseHiveModel.fromJson(Map<String, dynamic> json) =>
      _$CourseHiveModelFromJson(json);

  // ✅ TO JSON (Hive Model to API format)
  Map<String, dynamic> toJson() => _$CourseHiveModelToJson(this);

  @override
  List<Object?> get props => [
        courseId,
        courseName,
        coursePrice,
        instructor,
        courseImage,
        duration,
        category,
        courseDescription,
      ];
}

// hive try

// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:uuid/uuid.dart';

// import '../../../../app/constants/hive_table_constant.dart';

// part 'course_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.courseTableId)
// @JsonSerializable()
// class CourseHiveModel extends Equatable {
//   @HiveField(0)
//   final String? courseId;

//   @HiveField(1)
//   final String courseName;

//   @HiveField(2)
//   final num coursePrice;

//   @HiveField(3)
//   final String instructor;

//   @HiveField(4)
//   final String? courseImage;

//   @HiveField(5)
//   final String duration;

//   @HiveField(6)
//   final String? category;

//   @HiveField(7)
//   final String courseDescription;

//   CourseHiveModel({
//     String? courseId,
//     required this.courseName,
//     required this.coursePrice,
//     required this.instructor,
//     this.courseImage,
//     required this.duration,
//     this.category,
//     required this.courseDescription,
//   }) : courseId = courseId ?? const Uuid().v4();

//   factory CourseHiveModel.fromEntity(CourseEntity entity) {
//     return CourseHiveModel(
//       courseId: entity.courseId,
//       courseName: entity.courseName,
//       coursePrice: entity.coursePrice,
//       instructor: entity.instructor,
//       courseImage: entity.courseImage,
//       duration: entity.duration,
//       category: entity.category,
//       courseDescription: entity.courseDescription,
//     );
//   }

//   CourseEntity toEntity() {
//     return CourseEntity(
//       courseId: courseId,
//       courseName: courseName,
//       coursePrice: coursePrice,
//       instructor: instructor,
//       courseImage: courseImage,
//       duration: duration,
//       category: category,
//       courseDescription: courseDescription,
//     );
//   }

//   static List<CourseHiveModel> fromEntityList(List<CourseEntity> entities) {
//     return entities.map((e) => CourseHiveModel.fromEntity(e)).toList();
//   }

//   static List<CourseEntity> toEntityList(List<CourseHiveModel> entities) {
//     return entities.map((e) => e.toEntity()).toList();
//   }

//   factory CourseHiveModel.fromJson(Map<String, dynamic> json) =>
//       _$CourseHiveModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CourseHiveModelToJson(this);

//   @override
//   List<Object?> get props => [
//         courseId,
//         courseName,
//         coursePrice,
//         instructor,
//         courseImage,
//         duration,
//         category,
//         courseDescription,
//       ];
// }
