import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/entity/message_entity.dart';

abstract interface class IChatRepository {
  Future<Either<Failure, List<MessageEntity>>> getMessages(
      String token, String senderId, String receiverId);
  Future<Either<Failure, void>> sendMessage(
      String token, MessageEntity message, String receiverId);
  Future<Either<Failure, void>> deleteMessage(String token, String messageId);
}
