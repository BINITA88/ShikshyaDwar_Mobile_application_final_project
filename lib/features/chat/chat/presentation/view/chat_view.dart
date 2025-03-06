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

  String? firstSenderId; // 🔹 Holds the current user's sender ID

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessagesEvent(
          senderId: "unknown", // Temporary placeholder
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
      appBar: _buildAppBar(context),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.pink));
          }

          // 🔹 Assign the first sender ID dynamically
          if (firstSenderId == null && state.messages.isNotEmpty) {
            firstSenderId = state.messages.first.senderId;
          }

          return Column(
            children: [
              Expanded(child: _buildMessagesList(state.messages)),
              _buildMessageInput(),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    // List of static user images (at least 5)
    List<String> userImages = [
      "assets/images/pro.jpg",
      "assets/images/pro.jpg",
      "assets/images/pro.jpg",
      "assets/images/images1.jpg",
      "assets/images/images1.jpg",
    ];

    // Determine whether to use a network or asset image
    String imageUrl = widget.receiverImage.isNotEmpty
        ? "${ApiEndpoints.imageUrl}/${widget.receiverImage}".trim()
        : "";

    // Ensure URL has a valid scheme
    if (imageUrl.isNotEmpty &&
        !imageUrl.startsWith('http://') &&
        !imageUrl.startsWith('https://')) {
      imageUrl = "http://" + imageUrl; // Add `http://` if missing
    }

    // Assign an asset image if `receiverImage` is empty or invalid
    bool useAssetImage = imageUrl.isEmpty || imageUrl.contains("placeholder");

    // Assign a random or cyclic asset image based on username hash
    int index = widget.receiverUsername.hashCode % userImages.length;
    String selectedAssetImage = userImages[index];

    print("User Image URL: '$imageUrl'"); // Debugging

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: useAssetImage
                ? AssetImage(selectedAssetImage) as ImageProvider
                : NetworkImage(imageUrl),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Text(
            widget.receiverUsername,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      centerTitle: true,
      elevation: 1,
    );
  }

//   /// 🔹 **App Bar**
//   AppBar _buildAppBar(BuildContext context) {
//     // Determine the image URL
//     String imageUrl = widget.receiverImage.isNotEmpty
//         ? "${ApiEndpoints.imageUrl}/${widget.receiverImage}".trim()
//         : "https://via.placeholder.com/150";
// // Ensure URL has a valid scheme
//     if (!imageUrl.startsWith('http://') && !imageUrl.startsWith('https://')) {
//       imageUrl = "http://" + imageUrl; // Add `http://` if missing
//     }

//     print("User Image URL: '$imageUrl'"); // Debugging

//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.black),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(imageUrl),
//             radius: 20,
//           ),
//           const SizedBox(width: 10),
//           Text(
//             widget.receiverUsername,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.grey.shade100,
//       centerTitle: true,
//       elevation: 1,
//     );
//   }

  /// 🔹 **Builds Messages List**
  Widget _buildMessagesList(List<MessageEntity> messages) {
    if (messages.isEmpty) {
      return const Center(
        child: Text("No messages yet", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(10),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isSentByMe = message.senderId == firstSenderId;

        return Align(
          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment:
                isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                        color: isSentByMe
                            ? Colors.pink.shade200
                            : Colors.grey.shade200,
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
  /// 🔹 **Builds Message Input Field**
  /// 🔹 **Builds Message Input Field**
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.grey.shade100, // Background color
              borderRadius: BorderRadius.circular(20), // Rounded corners
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none, // Removes default border
                  enabledBorder:
                      InputBorder.none, // Removes border when not focused
                  focusedBorder:
                      InputBorder.none, // Removes border when focused
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12), // Adjust padding
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.pink.shade200,
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
        senderId: firstSenderId ?? "unknown",
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/entity/message_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view_model/bloc/chat_bloc.dart';

// class ChatScreen extends StatefulWidget {
//   final String receiverId;
//   final String receiverUsername;
//   final String receiverImage;

//   const ChatScreen({
//     super.key,
//     required this.receiverId,
//     required this.receiverUsername,
//     required this.receiverImage,
//   });

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final FocusNode _messageFocusNode = FocusNode();

//   String? firstSenderId;

//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatBloc>().add(LoadMessagesEvent(
//           senderId: "unknown",
//           receiverId: widget.receiverId,
//         ));
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: BlocListener<ChatBloc, ChatState>(
//         listener: (context, state) {
//           if (state.error != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error!),
//                 backgroundColor: Colors.red[700],
//               ),
//             );
//           }

//           if (firstSenderId == null && state.messages.isNotEmpty) {
//             setState(() {
//               firstSenderId = state.messages.first.senderId;
//             });
//           }

//           _scrollToBottom();
//         },
//         child: Column(
//           children: [
//             Expanded(child: _buildMessagesList()),
//             _buildMessageInput(),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Professional App Bar
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 1,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: Colors.red[700]),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Row(
//         children: [
//           Hero(
//             tag: 'user_avatar_${widget.receiverId}',
//             child: CircleAvatar(
//               radius: 22,
//               backgroundImage: widget.receiverImage.isNotEmpty
//                   ? NetworkImage(
//                       "${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//                   : const AssetImage("assets/images/default_avatar.png")
//                       as ImageProvider,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.receiverUsername,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.red[700],
//                 ),
//               ),
//               Text(
//                 'Online',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.green[600],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.videocam, color: Colors.red[700]),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.phone, color: Colors.red[700]),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   /// Enhanced Messages List
//   Widget _buildMessagesList() {
//     return BlocBuilder<ChatBloc, ChatState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return Center(
//             child: CircularProgressIndicator(color: Colors.red[700]),
//           );
//         }

//         final messages = state.messages;

//         if (messages.isEmpty) {
//           return Center(
//             child: Text(
//               "No messages yet",
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//           );
//         }

//         return ListView.builder(
//           controller: _scrollController,
//           padding: const EdgeInsets.all(16),
//           itemCount: messages.length,
//           itemBuilder: (context, index) {
//             final message = messages[index];
//             final isSentByMe = message.senderId == firstSenderId;

//             return Container(
//               margin: const EdgeInsets.symmetric(vertical: 4),
//               child: Row(
//                 mainAxisAlignment: isSentByMe
//                     ? MainAxisAlignment.end
//                     : MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   if (!isSentByMe) _buildReceiverAvatar(),
//                   Flexible(
//                     child: Container(
//                       constraints: BoxConstraints(
//                         maxWidth: MediaQuery.of(context).size.width * 0.7,
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 14,
//                       ),
//                       decoration: BoxDecoration(
//                         color: isSentByMe
//                             ? Colors.red[700]?.withOpacity(0.9)
//                             : Colors.grey[200],
//                         borderRadius: BorderRadius.only(
//                           topLeft: const Radius.circular(15),
//                           topRight: const Radius.circular(15),
//                           bottomLeft: isSentByMe
//                               ? const Radius.circular(15)
//                               : Radius.zero,
//                           bottomRight: isSentByMe
//                               ? Radius.zero
//                               : const Radius.circular(15),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 1,
//                             blurRadius: 3,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: isSentByMe
//                             ? CrossAxisAlignment.end
//                             : CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             message.message,
//                             style: TextStyle(
//                               color: isSentByMe ? Colors.white : Colors.black87,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             _formatTime(message.createdAt),
//                             style: TextStyle(
//                               color: isSentByMe
//                                   ? Colors.white54
//                                   : Colors.grey[600],
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   /// Receiver Avatar
//   Widget _buildReceiverAvatar() {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0, bottom: 10),
//       child: Hero(
//         tag: 'receiver_avatar_${widget.receiverId}',
//         child: CircleAvatar(
//           radius: 16,
//           backgroundImage: widget.receiverImage.isNotEmpty
//               ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//               : const AssetImage("assets/images/default_avatar.png")
//                   as ImageProvider,
//         ),
//       ),
//     );
//   }

//   /// Professional Message Input
//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.camera_alt, color: Colors.red[700]),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.mic, color: Colors.red[700]),
//             onPressed: () {},
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: TextField(
//                 controller: _controller,
//                 focusNode: _messageFocusNode,
//                 decoration: InputDecoration(
//                   hintText: 'Type a message...',
//                   hintStyle: TextStyle(color: Colors.grey[500]),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                 ),
//                 maxLines: null,
//                 minLines: 1,
//                 keyboardType: TextInputType.multiline,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           CircleAvatar(
//             backgroundColor: Colors.red[700],
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.white),
//               onPressed: _sendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Send Message Handler
//   void _sendMessage() {
//     if (_controller.text.trim().isNotEmpty) {
//       final chatBloc = context.read<ChatBloc>();
//       final newMessage = MessageEntity(
//         senderId: firstSenderId ?? "temp_user",
//         receiverId: widget.receiverId,
//         message: _controller.text.trim(),
//         createdAt: DateTime.now(),
//       );

//       chatBloc.add(SendMessage(
//         senderId: newMessage.senderId,
//         receiverId: widget.receiverId,
//         message: newMessage.message,
//       ));

//       _controller.clear();
//       _messageFocusNode.unfocus();
//       _scrollToBottom();
//     }
//   }

//   /// Format Time for Messages
//   String _formatTime(DateTime time) {
//     return DateFormat('hh:mm a').format(time);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     _messageFocusNode.dispose();
//     super.dispose();
//   }
// }
