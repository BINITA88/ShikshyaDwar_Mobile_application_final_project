import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/data/data_source/remote_datasource/exam_seat_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';

class ExamSeatRepositoryImpl implements IExamSeatRepository {
  final IExamSeatRemoteDataSource remoteDataSource;

  ExamSeatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ExamSeatEntity>>> getAllExamSeat() async {
    try {
      final seats = await remoteDataSource.fetchSeats();
      return Right(seats);
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to fetch seats'));
    }
  }

  @override
  Future<Either<Failure, ExamSeatEntity>> bookExamSeat(
      String seatNumber) async {
    try {
      final int parsedSeatNumber = int.tryParse(seatNumber) ?? -1;
      if (parsedSeatNumber == -1) {
        return Left(ApiFailure(message: 'Invalid seat number format'));
      }

      final seat = await remoteDataSource.bookSeat(parsedSeatNumber);
      return Right(seat);
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to book seat: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ExamSeatEntity>> unbookExamSeat(
      String seatNumber) async {
    try {
      final int parsedSeatNumber = int.tryParse(seatNumber) ?? -1;
      if (parsedSeatNumber == -1) {
        return Left(ApiFailure(message: 'Invalid seat number format'));
      }

      final seat = await remoteDataSource.unbookSeat(parsedSeatNumber);
      return Right(seat);
    } catch (e) {
      return Left(
          ApiFailure(message: 'Failed to unbook seat: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkSeatStatus(String seatNumber) {
    // TODO: implement checkSeatStatus
    throw UnimplementedError();
  }
}
