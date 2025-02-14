import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/core/socket_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/get_messages.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/send_message.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/widget/chat_input.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/widget/chat_message_list.dart';
import '../view_model/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String userId;

  const ChatScreen({Key? key, required this.receiverId, required this.userId})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SocketService socketService;
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    socketService = getIt<SocketService>();
    chatBloc = ChatBloc(
      getMessages: getIt<GetMessages>(),
      sendMessage: getIt<SendMessage>(),
      socketService: socketService,
    );

    socketService.connect(widget.userId, chatBloc);
  }

  @override
  void dispose() {
    socketService.disconnect();
    chatBloc.close(); // Properly dispose of BLoC
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text("Chat")),
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
