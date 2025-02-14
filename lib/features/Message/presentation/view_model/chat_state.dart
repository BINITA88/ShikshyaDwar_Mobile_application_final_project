import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';
import 'package:collection/collection.dart'; // ✅ Import ListEquality for deep comparison

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

/// ✅ Initial state when the chat screen is opened
class ChatInitial extends ChatState {}

/// ✅ State when messages are loading from the server
class ChatLoading extends ChatState {}

/// ✅ State when messages are successfully loaded
class ChatLoaded extends ChatState {
  final List<Message> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];

  /// ✅ Ensure deep equality check for messages list
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatLoaded &&
          runtimeType == other.runtimeType &&
          ListEquality().equals(messages, other.messages);

  @override
  int get hashCode => messages.hashCode;
}

/// ✅ State when a message is successfully sent
class ChatMessageSent extends ChatState {
  final Message message;

  const ChatMessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

/// ✅ State when an error occurs in chat
class ChatError extends ChatState {
  final String errorMessage;

  const ChatError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
