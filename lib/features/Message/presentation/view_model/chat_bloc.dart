import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/core/socket_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/get_messages.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/send_message.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final SocketService socketService;

  ChatBloc({
    required this.getMessages,
    required this.sendMessage,
    required this.socketService,
  }) : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      final messages = await getMessages(event.receiverId);
      emit(ChatLoaded(messages));
    });

    on<SendMessageEvent>((event, emit) async {
      final message = await sendMessage(event.receiverId, event.message);
      socketService.sendMessage(event.receiverId, event.message);
      emit(ChatMessageSent(message));
    });

    on<NewMessageReceived>((event, emit) async {
      if (state is ChatLoaded) {
        final updatedMessages = List<Message>.from((state as ChatLoaded).messages)
          ..add(event.message);
        emit(ChatLoaded(updatedMessages));
      }
    });
  }
}
