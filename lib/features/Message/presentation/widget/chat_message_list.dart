import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/chat_bloc.dart';
import '../view_model/chat_state.dart';
import 'chat_bubble.dart';

class ChatMessagesList extends StatefulWidget {
  final String receiverId;

  const ChatMessagesList({Key? key, required this.receiverId}) : super(key: key);

  @override
  _ChatMessagesListState createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatLoaded) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return ChatBubble(message: message);
            },
          );
        } else if (state is ChatError) {
          return Center(child: Text(state.errorMessage, style: const TextStyle(color: Colors.red)));
        } else {
          return const Center(child: Text("No messages yet"));
        }
      },
    );
  }
}
