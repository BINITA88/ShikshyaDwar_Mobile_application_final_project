import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/chat_bloc.dart';
import '../view_model/chat_state.dart';
import 'chat_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  final String receiverId;

  const ChatMessagesList({Key? key, required this.receiverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoaded) {
          return ListView.builder(
            reverse: true, // Ensures latest messages appear at the bottom
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return ChatBubble(message: message);
            },
          );
        } else if (state is ChatError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("No messages yet"));
        }
      },
    );
  }
}
