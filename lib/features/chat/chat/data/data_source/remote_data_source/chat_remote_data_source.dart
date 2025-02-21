// // import 'package:dio/dio.dart';
// // import 'package:koselie/app/constants/api_endpoints.dart';
// // import 'package:koselie/features/chat/data/data_source/chat_data_source.dart';
// // import 'package:koselie/features/chat/data/model/message_api_model.dart';
// // import 'package:koselie/features/chat/domain/entity/message_entity.dart';

// // class ChatRemoteDataSource implements IChatDataSource {
// //   final Dio _dio;

// //   ChatRemoteDataSource(this._dio);

// //   /// ✅ **Send Message and Fetch Updated Messages**
// //   @override
// //   Future<List<MessageEntity>> sendMessage(
// //       String token, MessageEntity message, String receiverId) async {
// //     try {
// //       await _dio.post(
// //         "${ApiEndpoints.sendMessage}/$receiverId",
// //         data: {
// //           "message": message.message, // ✅ Backend gets senderId from JWT
// //         },
// //         options: Options(headers: {
// //           "Authorization": "Bearer $token",
// //           "Content-Type": "application/json",
// //         }),
// //       );

// //       // ✅ After sending, fetch updated messages
// //       return await getMessages(token, message.senderId, receiverId);
// //     } on DioException catch (e) {
// //       throw Exception(
// //           "❌ Error sending message: ${e.response?.data ?? e.toString()}");
// //     }
// //   }

// //   /// ✅ **Fetch Messages Between Two Users**
// //   @override
// //   Future<List<MessageEntity>> getMessages(
// //       String token, String senderId, String receiverId) async {
// //     try {
// //       Response response = await _dio.get(
// //         "${ApiEndpoints.getMessages}/$receiverId",
// //         options: Options(headers: {
// //           "Authorization": "Bearer $token",
// //           "Content-Type": "application/json",
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         final List<dynamic> data = response.data['messages'];

// //         // ✅ Use MessageModel for JSON parsing
// //         return data
// //             .map((json) => MessageModel.fromJson(json).toEntity())
// //             .toList();
// //       } else {
// //         throw Exception(
// //             "❌ Failed to fetch messages: ${response.statusMessage}");
// //       }
// //     } on DioException catch (e) {
// //       throw Exception("❌ DioException: ${e.response?.data ?? e.toString()}");
// //     }
// //   }

// //   /// ✅ **Delete Message**
// //   @override
// //   Future<void> deleteMessage(String token, String messageId) async {
// //     try {
// //       Response response = await _dio.delete(
// //         "${ApiEndpoints.deleteMessage}/$messageId",
// //         options: Options(headers: {
// //           "Authorization": "Bearer $token",
// //         }),
// //       );

// //       if (response.statusCode != 200) {
// //         throw Exception(
// //             "❌ Failed to delete message: ${response.statusMessage}");
// //       }
// //     } on DioException catch (e) {
// //       throw Exception("❌ DioException: ${e.response?.data ?? e.toString()}");
// //     }
// //   }
// // }

// import 'package:dio/dio.dart';
// import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/data/data_source/chat_data_source.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/entity/message_entity.dart';

// class ChatRemoteDataSource implements IChatDataSource {
//   final Dio _dio;

//   ChatRemoteDataSource(this._dio);

//   /// ✅ **Send Message and Immediately Fetch Updated Messages**
//   @override
//   Future<List<MessageEntity>> sendMessage(
//       String token, MessageEntity message, String receiverId) async {
//     try {
//       await _dio.post(
//         "${ApiEndpoints.sendMessage}/$receiverId",
//         data: {
//           "message": message.message, // ✅ Only send text, backend gets senderId
//         },
//         options: Options(headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         }),
//       );

//       // ✅ After sending, immediately fetch updated messages
//       return await getMessages(token, message.senderId, receiverId);
//     } on DioException catch (e) {
//       throw Exception(
//           "❌ Error sending message: ${e.response?.data ?? e.toString()}");
//     }
//   }

//   /// ✅ **Fetch Messages Between aLogged-in User & Selected User**
//   @override
//   Future<List<MessageEntity>> getMessages(
//       String token, String senderId, String receiverId) async {
//     try {
//       Response response = await _dio.get(
//         "${ApiEndpoints.getMessages}/$receiverId", // ✅ Fetch full conversation
//         options: Options(headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         }),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['messages'] ?? [];

//         // ✅ Parse JSON into List<MessageEntity>
//         return data.map((json) {
//           return MessageEntity(
//             messageId: json['_id'] ?? "", // Prevent nulls
//             senderId: json['senderId'] ?? "", // Fix senderId issues
//             receiverId: json['receiverId'] ?? "", // Fix receiverId issues
//             message: json['message'] ?? "[No message]", // Handle missing text
//             createdAt: DateTime.tryParse(json['createdAt'] ?? "") ??
//                 DateTime.now(), // Fix null date
//           );
//         }).toList();
//       } else {
//         throw Exception(
//             "❌ Failed to fetch messages: ${response.statusMessage}");
//       }
//     } on DioException catch (e) {
//       throw Exception("❌ DioException: ${e.response?.data ?? e.toString()}");
//     }
//   }

//   /// ✅ **Delete Message**
//   @override
//   Future<void> deleteMessage(String token, String messageId) async {
//     try {
//       Response response = await _dio.delete(
//         "${ApiEndpoints.deleteMessage}/$messageId",
//         options: Options(headers: {
//           "Authorization": "Bearer $token",
//         }),
//       );

//       if (response.statusCode != 200) {
//         throw Exception(
//             "❌ Failed to delete message: ${response.statusMessage}");
//       }
//     } on DioException catch (e) {
//       throw Exception("❌ DioException: ${e.response?.data ?? e.toString()}");
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/data/data_source/chat_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/entity/message_entity.dart';

class ChatRemoteDataSource implements IChatDataSource {
  final Dio _dio;

  ChatRemoteDataSource(this._dio);

  /// ✅ **Send Message and Fetch Updated Messages**
  @override
  Future<List<MessageEntity>> sendMessage(
      String token, MessageEntity message, String receiverId) async {
    try {
      await _dio.post(
        "${ApiEndpoints.sendMessage}/$receiverId",
        data: {
          "message":
              message.message, // ✅ Only send text, backend determines senderId
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

      // ✅ After sending, fetch updated messages
      return await getMessages(token, message.senderId, receiverId);
    } on DioException catch (e) {
      throw Exception("❌ Error sending message: ${_handleDioError(e)}");
    }
  }

  /// ✅ **Fetch Messages Between Logged-in User & Selected User**
  @override
  Future<List<MessageEntity>> getMessages(
      String token, String senderId, String receiverId) async {
    try {
      Response response = await _dio.get(
        "${ApiEndpoints.getMessages}/$receiverId", // ✅ Fetch full conversation
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        if (responseData is List) {
          return responseData.map((json) {
            return MessageEntity(
              messageId:
                  json['_id']?.toString() ?? "", // ✅ Convert ObjectId to String
              senderId:
                  json['senderId']?.toString() ?? "", // ✅ Convert to String
              receiverId:
                  json['receiverId']?.toString() ?? "", // ✅ Convert to String
              message: json['message'] ??
                  "[No message]", // ✅ Default message if missing
              createdAt:
                  _parseDateTime(json['createdAt']), // ✅ Fix null date issue
            );
          }).toList();
        } else {
          throw Exception("❌ Invalid API response format: Expected a List");
        }
      } else {
        throw Exception(
            "❌ Failed to fetch messages: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("❌ DioException: ${_handleDioError(e)}");
    }
  }

  /// ✅ **Delete Message**
  @override
  Future<void> deleteMessage(String token, String messageId) async {
    try {
      Response response = await _dio.delete(
        "${ApiEndpoints.deleteMessage}/$messageId",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
            "❌ Failed to delete message: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("❌ DioException: ${_handleDioError(e)}");
    }
  }

  /// 🔹 **Handles API Date Parsing Issues**
  static DateTime _parseDateTime(dynamic date) {
    if (date is String) {
      return DateTime.tryParse(date) ?? DateTime.now(); // ✅ Parse safely
    }
    return DateTime.now(); // ✅ Default if null
  }

  /// 🔹 **Handles Dio Errors Gracefully**
  String _handleDioError(DioException e) {
    if (e.response != null) {
      return "Response: ${e.response?.data ?? 'Unknown error'}";
    } else {
      return "Request failed: ${e.message}";
    }
  }
}
