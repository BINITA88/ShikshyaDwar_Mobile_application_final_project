import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/get_all_seat.dart';

import 'booked_seat_repository.mock.dart';

void main() {
  late MockExamsSeatRepository mockRepository;
  late GetAllSeat usecase;

  setUp(() {
    mockRepository = MockExamsSeatRepository();
    usecase = GetAllSeat(mockRepository);
  });

  final examSeats = [
    ExamSeatEntity(examSeatId: "1", seatNumber: 101, booked: false),
    ExamSeatEntity(examSeatId: "2", seatNumber: 102, booked: true),
  ];

  test('should get all exam seats from repository', () async {
    when(() => mockRepository.getAllExamSeat())
        .thenAnswer((_) async => Right(examSeats));

    final result = await usecase();

    expect(result, Right(examSeats));
    verify(() => mockRepository.getAllExamSeat()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

