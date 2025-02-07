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

  @HiveField(2)
  final double coursePrice;

  @HiveField(3)
  final String instructor;

  @HiveField(4)
  final String courseImage;

  @HiveField(5)
  final String duration;

  @HiveField(6)
  final Object category;

  @HiveField(7)
  final String courseDescription;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
    required this.coursePrice,
    required this.instructor,
    required this.courseImage,
    required this.duration,
    required this.category,
    required this.courseDescription,
  }) : courseId = courseId ?? const Uuid().v4();

  // Initial Constructor
  const CourseHiveModel.initial()
      : courseId = '',
        courseName = '',
        coursePrice = 0.0,
        instructor = '',
        courseImage = '',
        duration = '',
        category = '',
        courseDescription = '';

  // From Entity
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

  // To Entity
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

  // From entity list to model list
  static List<CourseHiveModel> fromEntityList(List<CourseEntity> entities) {
    return entities.map((e) => CourseHiveModel.fromEntity(e)).toList();
  }

  // To entity list
  static List<CourseEntity> toEntityList(List<CourseHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

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
