import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the chat is idle
class ChatInitial extends ChatState {}

/// State when messages are loading
class ChatLoading extends ChatState {}

/// State when messages have loaded successfully
class ChatLoaded extends ChatState {
  final List<Message> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

/// State when a message is successfully sent
class ChatMessageSent extends ChatState {
  final Message message;

  const ChatMessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when an error occurs in chat
class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
