
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
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: DateTime.parse(json['createdAt']),
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
