import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/data/model/notice_api_model.dart';

abstract class INoticeRemoteDataSource {
  Future<List<NoticeModel>> fetchNotices();
}

class NoticeRemoteDataSource implements INoticeRemoteDataSource {
  final Dio _dio;

  NoticeRemoteDataSource(this._dio);

  @override
  Future<List<NoticeModel>> fetchNotices() async {
    try {
      final response = await _dio.get(ApiEndpoints.getnotice);

      print("🔍 API Response: ${response.data}"); // ✅ Debugging API Response

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          // ✅ Extract list from expected key (adjust key based on API response)
          final List<dynamic> data = response.data['notices'] ?? [];
          return data.map((e) => NoticeModel.fromJson(e)).toList();
        } else if (response.data is List) {
          // ✅ If API directly returns a List, parse it normally
          return (response.data as List)
              .map((e) => NoticeModel.fromJson(e))
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load notices: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error Fetching Notices: $e"); // ✅ Debugging API Call Failure
      throw Exception("Failed to load notices");
    }
  }
}
