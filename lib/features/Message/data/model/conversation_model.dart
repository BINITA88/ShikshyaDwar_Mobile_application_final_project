import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/conversation.dart';

import 'message_model.dart';

class ConversationModel extends Conversation {
  ConversationModel({
    required super.id,
    required super.participants,
    required super.messages,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      participants: List<String>.from(json['participants']),
      messages:
          List<MessageModel>.from(json['messages'].map((x) => MessageModel.fromJson(x))),
    );
  }
}
