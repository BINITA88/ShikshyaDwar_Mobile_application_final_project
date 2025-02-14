import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/core/socket_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/get_messages.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/send_message.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/widget/chat_input.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/widget/chat_message_list.dart';
import '../view_model/chat_bloc.dart';
import '../view_model/chat_event.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String userId;

  const ChatScreen({super.key, required this.receiverId, required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketManager socketService;
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();

    // ✅ Get WebSocketManager instance
    socketService = getIt<WebSocketManager>();

    // ✅ Initialize ChatBloc with dependencies
    chatBloc = ChatBloc(
      getMessages: getIt<GetMessages>(),
      sendMessage: getIt<SendMessage>(),
      socketService: socketService,
    );

    // ✅ Connect WebSocket with userId
    socketService.connect(widget.userId);

    // ✅ Load previous messages when screen starts
    chatBloc.add(LoadMessages(widget.receiverId));
  }

  @override
  void dispose() {
    chatBloc.close(); // ✅ Properly dispose of BLoC
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: ChatMessagesList(receiverId: widget.receiverId)),
            ChatInput(receiverId: widget.receiverId),
          ],
        ),
      ),
    );
  }
}
