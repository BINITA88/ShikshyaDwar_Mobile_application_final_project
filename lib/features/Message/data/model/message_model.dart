import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.message,
    required super.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'].toString(), // ✅ Ensure ID is always a String
      senderId: json['senderId'].toString(),
      receiverId: json['receiverId'].toString(),
      message: json['message'] ?? "",
      timestamp: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ??
              DateTime.now() // ✅ Handle timestamp parsing
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "createdAt": timestamp.toIso8601String(),
    };
  }
}
