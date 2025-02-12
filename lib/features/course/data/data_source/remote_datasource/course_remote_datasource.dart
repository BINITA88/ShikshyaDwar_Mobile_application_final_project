import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/course_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/dto/get_all_course_details_dto.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/dto/get_all_course_dto.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class CourseRemoteDataSource implements ICourseDataSource {
  final Dio _dio;

  CourseRemoteDataSource(this._dio);

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllCourse);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var courseDTO = GetAllCourseDTO.fromJson(response.data);
        // Convert DTO to Entity
        return CourseApiModel.toEntityList(courseDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
Future<CourseEntity> getCourseDetailsById(String courseId) async {
  try {
    var response = await _dio.get("${ApiEndpoints.getCourseDetailById}/$courseId");

    print("Raw API Response: ${response.data}"); // ✅ Debugging

    if (response.statusCode == 200 && response.data != null) {
      // ✅ Ensure response is correctly formatted
      final json = response.data as Map<String, dynamic>;

      final courseDTO = GetCourseDetailsByIdDTO.fromJson(json); // ✅ Directly parse JSON object
      return courseDTO.toDomain(); // ✅ Convert DTO to domain entity
    } else {
      throw Exception("Failed to fetch course details. Status: ${response.statusCode}");
    }
  } on DioException catch (e) {
    print("Dio Error: ${e.message}");
    throw Exception("Dio Error: ${e.message}");
  } catch (e) {
    print("Error: ${e.toString()}");
    throw Exception("Error: ${e.toString()}");
  }
}

}
