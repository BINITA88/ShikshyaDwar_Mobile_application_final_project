import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';

abstract interface class INoticeRepository {
  Future<Either<Failure, List<NoticeEntity>>> getAllNotice();
}
