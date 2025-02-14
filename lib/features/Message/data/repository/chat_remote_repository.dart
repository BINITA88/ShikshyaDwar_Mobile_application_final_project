

import 'package:shikshyadwar_mobile_application_project/features/Message/data/data_source/chat_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/data/model/message_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MessageModel>> getMessages(String receiverId) {
    return remoteDataSource.getMessages(receiverId);
  }

  @override
  Future<MessageModel> sendMessage(String receiverId, String message) {
    return remoteDataSource.sendMessage(receiverId, message);
  }
}
