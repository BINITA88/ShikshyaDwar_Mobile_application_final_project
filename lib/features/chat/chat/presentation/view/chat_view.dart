import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/entity/message_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view_model/bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverUsername;
  final String receiverImage;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverUsername,
    required this.receiverImage,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? firstSenderId; // 🔹 This will hold the first sender as "current user"

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessagesEvent(
          senderId:
              "unknown", // Temporary placeholder (not used for display logic)
          receiverId: widget.receiverId,
        ));
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error!), backgroundColor: Colors.red),
            );
          }

          // 🔹 Assign the first sender as "current user"
          if (firstSenderId == null && state.messages.isNotEmpty) {
            setState(() {
              firstSenderId = state.messages.first.senderId;
            });
          }

          _scrollToBottom();
        },
        child: Column(
          children: [
            Expanded(child: _buildMessagesList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  /// 🔹 **App Bar**
  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: widget.receiverImage.isNotEmpty
                ? NetworkImage(
                    "${ApiEndpoints.imageUrl}/${widget.receiverImage}")
                : const AssetImage("assets/images/default_avatar.png")
                    as ImageProvider,
          ),
          const SizedBox(width: 10),
          Text(
            widget.receiverUsername,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      centerTitle: true,
      elevation: 1,
    );
  }

  /// 🔹 **Builds Messages List**
  Widget _buildMessagesList() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        }

        final messages = state.messages;

        if (messages.isEmpty) {
          return const Center(
            child:
                Text("No messages yet", style: TextStyle(color: Colors.grey)),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(10),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            // 🔹 Determine if this message is from the first sender
            final isSentByMe = message.senderId == firstSenderId;

            return Align(
              alignment:
                  isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: isSentByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: isSentByMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isSentByMe) _buildReceiverAvatar(),
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                            color:
                                isSentByMe ? Colors.blue : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15),
                              topRight: const Radius.circular(15),
                              bottomLeft: isSentByMe
                                  ? const Radius.circular(15)
                                  : Radius.zero,
                              bottomRight: isSentByMe
                                  ? Radius.zero
                                  : const Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            message.message,
                            style: TextStyle(
                              color: isSentByMe ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      _formatTime(message.createdAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// 🔹 **Builds Receiver's Avatar**
  Widget _buildReceiverAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, bottom: 10),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: widget.receiverImage.isNotEmpty
            ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
            : const AssetImage("assets/images/default_avatar.png")
                as ImageProvider,
      ),
    );
  }

  /// 🔹 **Builds Message Input Field**
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 **Handles Sending Messages**
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final chatBloc = context.read<ChatBloc>();
      final newMessage = MessageEntity(
        senderId: firstSenderId ??
            "temp_user", // 🔹 Assign the first sender ID dynamically
        receiverId: widget.receiverId,
        message: _controller.text,
        createdAt: DateTime.now(),
      );

      chatBloc.add(SendMessage(
        senderId: newMessage.senderId,
        receiverId: widget.receiverId,
        message: newMessage.message,
      ));

      _controller.clear();
      _scrollToBottom();
    }
  }

  /// 🔹 **Formats Time for Messages**
  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
