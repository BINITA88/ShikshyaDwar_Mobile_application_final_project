import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'course_hive_model.g.dart';

// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String? courseId;

  @HiveField(1)
  final String courseName;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

// Initial Constructor
  const CourseHiveModel.initial()
      : courseId = '',
        courseName = '';

// From Entity
  factory CourseHiveModel.fromEntity(CourseEntity entity) {
    return CourseHiveModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
    );
  }

  // to entity
  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      courseName: courseName,
    );
  }

// from entity list to model list
  static List<CourseHiveModel> fromEntityList(List<CourseEntity> entities) {
    return entities.map((e) => CourseHiveModel.fromEntity(e)).toList();
  }

  // to entity list
  static List<CourseEntity> toEntityList(List<CourseHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [courseId, courseName];
}