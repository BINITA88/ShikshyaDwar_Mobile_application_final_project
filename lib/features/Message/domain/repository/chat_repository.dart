import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(String receiverId);
  Future<Message> sendMessage(String receiverId, String message);
}
