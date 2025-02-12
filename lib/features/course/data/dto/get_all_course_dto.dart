import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_api_model.dart';

part 'get_all_course_dto.g.dart';

@JsonSerializable()
class GetAllCourseDTO {
  final List<CourseApiModel> data;

  GetAllCourseDTO({
    required this.data,
  });

  factory GetAllCourseDTO.fromJson(List<dynamic> jsonList) {
    return GetAllCourseDTO(
      data: jsonList
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJson() => data.map((e) => e.toJson()).toList();
}
