import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/book_seat.dart';

import 'seat_repository.mock.dart';

void main() {
  late MockExamSeatRepository mockRepository;
  late BookSeat usecase;

  setUp(() {
    mockRepository = MockExamSeatRepository();
    usecase = BookSeat(mockRepository);
  });

  const seatId = "1";
  final updatedSeat = ExamSeatEntity(examSeatId: seatId, seatNumber: 101, booked: true);

  test('should book an exam seat from repository', () async {
    when(() => mockRepository.bookExamSeat(seatId)).thenAnswer((_) async => Right(updatedSeat));

    final result = await usecase(seatId);

    expect(result, Right(updatedSeat));
    verify(() => mockRepository.bookExamSeat(seatId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
