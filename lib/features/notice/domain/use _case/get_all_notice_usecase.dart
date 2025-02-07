import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/repository/notice_repository.dart';

class GetAllNoticeUsecase implements UsecaseWithoutParams<List<NoticeEntity>> {
  final INoticeRepository noticeRepository;

  GetAllNoticeUsecase(this.noticeRepository);

  @override
  Future<Either<Failure, List<NoticeEntity>>> call() {
    return noticeRepository.getAllNotice();
  }
}
