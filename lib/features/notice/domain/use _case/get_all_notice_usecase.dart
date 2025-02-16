import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import '../entity/notice_entity.dart';
import '../repository/notice_repository.dart';

class GetAllNoticesUseCase {
  final INoticeRepository noticeRepository;

  GetAllNoticesUseCase({required this.noticeRepository});

  Future<Either<Failure, List<NoticeEntity>>> call() async {
    return await noticeRepository.getAllNotice();
  }
}
