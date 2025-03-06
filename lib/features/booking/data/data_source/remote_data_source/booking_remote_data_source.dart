import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/data/data_source/remote_data_source/booking_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/data/model/booking_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);

  @override
  Future<void> createBooking(BookingsEntity booking) async {
    try {
      // Convert entity to model
      var authApiModel = BookingApiModel.fromEntity(booking);
      var response = await _dio.post(
        ApiEndpoints.courseBooking,
        data: authApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
