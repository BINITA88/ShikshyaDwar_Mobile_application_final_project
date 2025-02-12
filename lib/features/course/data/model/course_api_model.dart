import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

part 'course_api_model.g.dart';

@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? courseId;

  @JsonKey(name: 'product_name')
  final String courseName;

  @JsonKey(name: 'product_price')
  final num coursePrice;

  final String instructor;

  @JsonKey(name: 'product_image')
  final String? courseImage;

  final String duration;

  final String? category;

  @JsonKey(name: 'product_description')
  final String courseDescription;

  CourseApiModel({
    this.courseId,
    required this.courseName,
    required this.coursePrice,
    required this.instructor,
    this.courseImage,
    required this.duration,
    this.category,
    required this.courseDescription,
  });
  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  // To entity

// From Entity
  factory CourseApiModel.fromEntity(CourseEntity entity) {
    return CourseApiModel(
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

  // To Entity List
  static List<CourseEntity> toEntityList(List<CourseApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<CourseApiModel> fromEntityList(List<CourseEntity> entityList) {
    return entityList
        .map((entity) => CourseApiModel.fromEntity(entity))
        .toList();
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
