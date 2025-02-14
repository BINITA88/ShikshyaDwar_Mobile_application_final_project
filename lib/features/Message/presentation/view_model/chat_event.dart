import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

/// ✅ Event to load messages from the database
class LoadMessages extends ChatEvent {
  final String receiverId;

  const LoadMessages(this.receiverId);

  @override
  List<Object?> get props => [receiverId];
}

/// ✅ Event to send a new message
class SendMessageEvent extends ChatEvent {
  final String receiverId;
  final String message;

  const SendMessageEvent(this.receiverId, this.message);

  @override
  List<Object?> get props => [receiverId, message];
}

/// ✅ Event triggered when a new message is received via WebSocket
class NewMessageReceived extends ChatEvent {
  final Message message;

  const NewMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}
