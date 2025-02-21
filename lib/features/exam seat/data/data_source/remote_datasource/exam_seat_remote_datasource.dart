import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/data/model/remote_api_model/exam_seat_remote_api_model.dart';

abstract class IExamSeatRemoteDataSource {
  Future<List<ExamSeatModel>> fetchSeats();
  Future<ExamSeatModel> bookSeat(int seatNumber);
  Future<ExamSeatModel> unbookSeat(int seatNumber);
}

class ExamSeatRemoteDataSourceImpl implements IExamSeatRemoteDataSource {
  final Dio _dio;

  ExamSeatRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ExamSeatModel>> fetchSeats() async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}seat/');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => ExamSeatModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Unexpected API response format');
      }
    } catch (e) {
      throw Exception('Failed to load seats: $e');
    }
  }

  @override
  Future<ExamSeatModel> bookSeat(int seatNumber) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}seat/book',
        data: {
          "seatNumber": seatNumber, // ✅ Send seatNumber as an integer
        },
      );

      if (response.statusCode == 200 && response.data['seat'] != null) {
        return ExamSeatModel.fromJson(response.data['seat']);
      } else {
        throw Exception('Failed to book seat: Invalid response');
      }
    } catch (e) {
      throw Exception('Failed to book seat: $e');
    }
  }

  @override
  Future<ExamSeatModel> unbookSeat(int seatNumber) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}seat/unbook',
        data: {
          "seatNumber": seatNumber, // ✅ Send seatNumber correctly
        },
      );

      if (response.statusCode == 200 && response.data['seat'] != null) {
        return ExamSeatModel.fromJson(response.data['seat']);
      } else {
        throw Exception('Failed to unbook seat: Invalid response');
      }
    } catch (e) {
      throw Exception('Failed to unbook seat: $e');
    }
  }
}
