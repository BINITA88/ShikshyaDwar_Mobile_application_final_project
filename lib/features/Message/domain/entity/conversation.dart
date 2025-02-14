import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';

class Conversation {
  final String id;
  final List<String> participants;
  final List<Message> messages;

  const Conversation({
    required this.id,
    required this.participants,
    required this.messages,
  });
}
