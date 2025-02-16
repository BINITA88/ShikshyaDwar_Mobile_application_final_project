import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/data/model/routine_model.dart';

abstract class RoutineRemoteDataSource {
  Future<List<RoutineModel>> fetchRoutines();
}

class RoutineRemoteDataSourceImpl implements RoutineRemoteDataSource {
  final Dio _dio;

  RoutineRemoteDataSourceImpl(this._dio);

  @override
  Future<List<RoutineModel>> fetchRoutines() async {
    final response = await _dio.get('/routines');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => RoutineModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load routines');
    }
  }
}
