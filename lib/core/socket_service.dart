import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/view_model/chat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/presentation/view_model/chat_event.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(String userId, ChatBloc chatBloc) {
    socket = IO.io(
      "http://10.0.2.2:9000/api/",
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .setQuery({"userId": userId})
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      print("Connected to WebSocket");
    });

    socket.onDisconnect((_) {
      print("Disconnected from WebSocket");
    });

    // Handle new incoming messages from WebSocket
    socket.on("newMessage", (data) {
      final newMessage = Message(
        id: data["_id"],
        senderId: data["senderId"],
        receiverId: data["receiverId"],
        message: data["message"],
        timestamp: DateTime.parse(data["createdAt"]),
      );

      print("New Message Received: ${newMessage.message}");

      // Dispatch event to update UI
      chatBloc.add(NewMessageReceived(newMessage));
    });

    socket.onError((data) {
      print("WebSocket Error: $data");
    });
  }

  void sendMessage(String receiverId, String message) {
    socket.emit("sendMessage", {"receiverId": receiverId, "message": message});
  }

  void disconnect() {
    socket.disconnect();
  }
}
