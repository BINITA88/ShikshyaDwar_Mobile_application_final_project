import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

part 'get_all_course_details_dto.g.dart';

// sadsa
@JsonSerializable()
class GetCourseDetailsByIdDTO {
  final CourseApiModel data;

  GetCourseDetailsByIdDTO({required this.data});

  /// ✅ Fixed: Properly parses JSON to DTO
  factory GetCourseDetailsByIdDTO.fromJson(Map<String, dynamic> json) {
    return GetCourseDetailsByIdDTO(
      data: CourseApiModel.fromJson(json), // ✅ Directly parse response JSON
    );
  }

  /// ✅ Converts DTO to Domain Entity
  CourseEntity toDomain() {
    return CourseEntity(
      courseId: data.courseId ?? '',
      courseName: data.courseName ?? 'Unknown',
      coursePrice: data.coursePrice ?? 0,
      instructor: data.instructor ?? 'Unknown',
      courseImage: data.courseImage ?? '',
      duration: data.duration ?? 'N/A',
      courseDescription: data.courseDescription ?? 'No description available',
      category: data.category ?? 'Uncategorized',
    );
  }
}
