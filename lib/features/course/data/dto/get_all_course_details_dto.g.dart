// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_course_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCourseDetailsByIdDTO _$GetCourseDetailsByIdDTOFromJson(
        Map<String, dynamic> json) =>
    GetCourseDetailsByIdDTO(
      data: CourseApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCourseDetailsByIdDTOToJson(
        GetCourseDetailsByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
