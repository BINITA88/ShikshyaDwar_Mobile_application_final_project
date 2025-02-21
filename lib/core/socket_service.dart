// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:shikshyadwar_mobile_application_project/features/Message/domain/entity/message.dart';

// class WebSocketManager {
//   late IO.Socket socket;
//   final StreamController<Message> _messageStreamController =
//       StreamController.broadcast();

//   Stream<Message> get messageStream => _messageStreamController.stream;

//   void connect(String userId) {
//     print("🟢 Connecting to WebSocket...");

//     socket = IO.io(
//       "http://10.0.2.2:9000",
//       IO.OptionBuilder()
//           .setTransports(["websocket"])
//           .setQuery({"userId": userId})
//           .enableForceNewConnection()
//           .setExtraHeaders({"Connection": "Upgrade", "Upgrade": "websocket"})
//           .build(),
//     );

//     socket.connect();

//     socket.onConnect((_) {
//       print("✅ Connected to WebSocket");
//     });

//     socket.on("newMessage", (data) async {
//       try {
//         final newMessage = Message(
//           id: data["_id"],
//           senderId: data["senderId"],
//           receiverId: data["receiverId"],
//           message: data["message"],
//           timestamp: DateTime.parse(data["createdAt"]),
//         );

//         print("📩 New Message Received: ${newMessage.message}");
//         _messageStreamController.add(newMessage);
//       } catch (e) {
//         print("⚠️ WebSocket Parsing Error: $e");
//       }
//     });

//     socket.onDisconnect((_) {
//       print("❌ Disconnected from WebSocket");
//     });

//     socket.onError((error) {
//       print("⚠️ WebSocket Error: $error");
//     });
//   }

//   void sendMessage(String receiverId, String message) {
//     print("📤 Sending message: $message to $receiverId");
//     socket.emit("sendMessage", {"receiverId": receiverId, "message": message});
//   }

//   void disconnect() {
//     socket.disconnect();
//     _messageStreamController.close();
//   }
// }
