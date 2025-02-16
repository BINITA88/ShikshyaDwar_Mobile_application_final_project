import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/data/model/routine_model.dart';

abstract class RoutineRemoteDataSource {
  Future<List<RoutineModel>> fetchRoutines();
}

class RoutineRemoteDataSourceImpl implements RoutineRemoteDataSource {
  final Dio _dio;

  RoutineRemoteDataSourceImpl(this._dio);

  @override
  Future<List<RoutineModel>> fetchRoutines() async {
    try {
      final response = await _dio.get(ApiEndpoints.getroutine);

      print(
          "🔍 API Response Data: ${response.data}"); // ✅ Debugging API response

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          // ✅ Extract the list from "schedules" key
          final List<dynamic> data =
              response.data["schedules"] as List<dynamic>;
          return data.map((json) => RoutineModel.fromJson(json)).toList();
        } else {
          throw Exception("Unexpected API response format: Expected a Map");
        }
      } else {
        throw Exception(
            'Failed to load routines, Status: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error Fetching Routines: $e"); // ✅ Debugging API Call Failure
      throw Exception("Failed to load routines");
    }
  }
}
