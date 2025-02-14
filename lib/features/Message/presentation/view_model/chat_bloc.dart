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
  final WebSocketManager socketService;

  ChatBloc({
    required this.getMessages,
    required this.sendMessage,
    required this.socketService,
  }) : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        final messages = await getMessages(event.receiverId);
        emit(ChatLoaded(messages));
      } catch (e) {
        emit(ChatError("Failed to load messages"));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      try {
        final message = await sendMessage(event.receiverId, event.message);
        socketService.sendMessage(event.receiverId, event.message);
        
        if (state is ChatLoaded) {
          final updatedMessages = List<Message>.from((state as ChatLoaded).messages)
            ..add(message);
          emit(ChatLoaded(updatedMessages));
        }
      } catch (e) {
        emit(ChatError("Failed to send message"));
      }
    });

    // ✅ Listen to WebSocketManager's message stream
    socketService.messageStream.listen((message) {
      add(NewMessageReceived(message));
    });

    on<NewMessageReceived>((event, emit) {
      if (state is ChatLoaded) {
        final updatedMessages = List<Message>.from((state as ChatLoaded).messages)
          ..add(event.message);
        emit(ChatLoaded(updatedMessages));
      }
    });
  }

  @override
  Future<void> close() {
    socketService.disconnect();
    return super.close();
  }
}
