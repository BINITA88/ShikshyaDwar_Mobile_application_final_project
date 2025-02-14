import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/data/model/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<MessageModel>> getMessages(String receiverId);
  Future<MessageModel> sendMessage(String receiverId, String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({required this.dio});

  /// ✅ **Fetch Messages by Receiver ID**
  @override
  Future<List<MessageModel>> getMessages(String receiverId) async {
    try {
      if (receiverId.isEmpty) throw Exception("❌ Receiver ID is missing");

      print("📡 Fetching messages for receiverId: $receiverId"); // ✅ Debug log
      final response = await dio.get(
        'http://10.0.2.2:9000/api/messages/$receiverId',
      );

      print("✅ API Response: ${response.data}"); // ✅ Log response data

      if (response.data == null || response.data is! List) {
        throw Exception("❌ Invalid API response format");
      }

      return response.data
          .map<MessageModel>((json) => MessageModel.fromJson(json))
          .toList();
    } catch (e) {
      print("⚠️ Dio Error (getMessages): $e");
      rethrow;
    }
  }

  /// ✅ **Send Message**
  @override
  Future<MessageModel> sendMessage(String receiverId, String message) async {
    try {
      if (receiverId.isEmpty) throw Exception("❌ Receiver ID is missing");
      if (message.isEmpty) throw Exception("❌ Message content is empty");

      print(
          "📤 Sending message: $message to receiverId: $receiverId"); // ✅ Debug log

      final response = await dio.post(
        'http://10.0.2.2:9000/api/messages/send/$receiverId',
        data: {"message": message},
      );

      print("✅ Message Sent Response: ${response.data}");

      if (response.data == null)
        throw Exception("❌ API returned null response");

      return MessageModel.fromJson(response.data);
    } catch (e) {
      print("⚠️ Dio Error (sendMessage): $e");
      rethrow;
    }
  }
}
