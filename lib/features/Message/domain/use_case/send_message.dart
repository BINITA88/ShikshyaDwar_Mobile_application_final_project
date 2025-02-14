import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/repository/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<Message> call(String receiverId, String message) {
    return repository.sendMessage(receiverId, message);
  }
}
