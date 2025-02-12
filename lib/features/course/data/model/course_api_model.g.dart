// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseApiModel _$CourseApiModelFromJson(Map<String, dynamic> json) =>
    CourseApiModel(
      courseId: json['_id'] as String?,
      courseName: json['product_name'] as String,
      coursePrice: json['product_price'] as num,
      instructor: json['instructor'] as String,
      courseImage: json['product_image'] as String?,
      duration: json['duration'] as String,
      category: json['category'] as String?,
      courseDescription: json['product_description'] as String,
    );

Map<String, dynamic> _$CourseApiModelToJson(CourseApiModel instance) =>
    <String, dynamic>{
      '_id': instance.courseId,
      'product_name': instance.courseName,
      'product_price': instance.coursePrice,
      'instructor': instance.instructor,
      'product_image': instance.courseImage,
      'duration': instance.duration,
      'category': instance.category,
      'product_description': instance.courseDescription,
    };
