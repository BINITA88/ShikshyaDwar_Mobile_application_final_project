import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/data/model/notice_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/data/remote_data_source/notice_remote_datasource.dart';
import '../../domain/entity/notice_entity.dart';
import '../../domain/repository/notice_repository.dart';

class NoticeRepositoryImpl implements INoticeRepository {
  final INoticeRemoteDataSource remoteDataSource;

  NoticeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NoticeEntity>>> getAllNotice() async {
    try {
      final List<NoticeModel> notices = await remoteDataSource.fetchNotices();
      return Right(notices); // ✅ NoticeModel extends NoticeEntity, so it works
    } catch (e) {
      return Left(ApiFailure(message: 'sad'));
    }
  }
}
