import 'package:shikshyadwar_mobile_application_project/features/Message/data/data_source/chat_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/data/model/message_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MessageModel>> getMessages(String receiverId) {
    return remoteDataSource.getMessages(receiverId);
  }

  @override
  Future<MessageModel> sendMessage(String receiverId, String message) {
    return remoteDataSource.sendMessage(receiverId, message);
  }
}

// import 'package:dio/dio.dart';
// import 'package:shikshyadwar_mobile_application_project/features/Message/data/model/message_model.dart';

// abstract class ChatRemoteDataSource {
//   Future<List<MessageModel>> getMessages(String receiverId);
//   Future<MessageModel> sendMessage(String receiverId, String message);
// }

// class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
//   final Dio dio;

//   ChatRemoteDataSourceImpl({required this.dio});

//   @override
//   Future<List<MessageModel>> getMessages(String receiverId) async {
//     try {
//       final response =
//           await dio.get('http://10.0.2.2:9000/api/chat/$receiverId');

//       if (response.statusCode == 200) {
//         return (response.data as List)
//             .map((e) => MessageModel.fromJson(e))
//             .toList();
//       } else {
//         throw Exception("❌ Failed to fetch messages");
//       }
//     } catch (e) {
//       print("⚠️ Dio Error (getMessages): $e");
//       throw Exception("❌ API Request Error");
//     }
//   }

//   @override
//   Future<MessageModel> sendMessage(String receiverId, String message) async {
//     try {
//       final response = await dio.post(
//         'http://10.0.2.2:9000/api/chat/send/$receiverId', // ✅ Corrected API Endpoint
//         data: {"message": message},
//         options: Options(
//           headers: {"Content-Type": "application/json"},
//         ),
//       );

//       if (response.statusCode == 200) {
//         return MessageModel.fromJson(response.data);
//       } else {
//         throw Exception("❌ Failed to send message");
//       }
//     } catch (e) {
//       print("⚠️ Dio Error (sendMessage): $e");
//       throw Exception("❌ API Request Error");
//     }
//   }
// }
