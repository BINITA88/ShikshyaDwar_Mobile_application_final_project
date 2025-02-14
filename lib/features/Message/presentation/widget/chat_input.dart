import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/chat_bloc.dart';
import '../view_model/chat_event.dart';

class ChatInput extends StatefulWidget {
  final String receiverId;

  const ChatInput({Key? key, required this.receiverId}) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(BuildContext context) {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      BlocProvider.of<ChatBloc>(context)
          .add(SendMessageEvent(widget.receiverId, messageText));
      _controller.clear(); // Clear input field after sending message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () => _sendMessage(context),
          ),
        ],
      ),
    );
  }
}
