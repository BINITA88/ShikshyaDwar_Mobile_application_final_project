import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/data/model/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<MessageModel>> getMessages(String receiverId);
  Future<MessageModel> sendMessage(String receiverId, String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MessageModel>> getMessages(String receiverId) async {
    final response = await dio.get('/chat/$receiverId');
    return (response.data as List).map((e) => MessageModel.fromJson(e)).toList();
  }

  @override
  Future<MessageModel> sendMessage(String receiverId, String message) async {
    final response = await dio.post('/chat/send/$receiverId', data: {"message": message});
    return MessageModel.fromJson(response.data);
  }
}
