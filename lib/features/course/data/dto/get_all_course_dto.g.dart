// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCourseDTO _$GetAllCourseDTOFromJson(Map<String, dynamic> json) =>
    GetAllCourseDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCourseDTOToJson(GetAllCourseDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
