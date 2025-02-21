
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/entity/message_entity.dart';

abstract class IChatDataSource {
  Future<void> sendMessage(
      String token, MessageEntity message, String receiverId);
  Future<List<MessageEntity>> getMessages(
      String token, String senderId, String receiverId);
  // Future<List<MessageEntity>> getMessages(
  //     String token, String senderId, String receiverId);
  Future<void> deleteMessage(String token, String messageId);
}
