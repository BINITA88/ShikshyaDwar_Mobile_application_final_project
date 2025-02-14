import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/repository/chat_repository.dart';


class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Future<List<Message>> call(String receiverId) {
    return repository.getMessages(receiverId);
  }
}
