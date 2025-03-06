// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/get_all_seat.dart';

// import 'booked_seat_repository.mock.dart';

// void main() {
//   late MockExamsSeatRepository mockRepository;
//   late GetAllSeat usecase;

//   setUp(() {
//     mockRepository = MockExamsSeatRepository();
//     usecase = GetAllSeat(mockRepository);
//   });

//   final examSeats = [
//     ExamSeatEntity(examSeatId: "1", seatNumber: 'A1', booked: false),
//     ExamSeatEntity(examSeatId: "2", seatNumber: 'B2', booked: true),
//   ];

//   test('should get all exam seats from repository', () async {
//     // Arrange
//     when(() => mockRepository.getAllExamSeat())
//         .thenAnswer((_) async => Right(examSeats));

//     // Act
//     final result = await usecase();

//     // Assert
//     expect(result, Right(examSeats));
//     verify(() => mockRepository.getAllExamSeat()).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });

//   // ✅ New Test: Should return a Failure when the repository fails
//   test('should return a Failure when repository fails to get exam seats',
//       () async {
//     // Arrange
//     final failure = ApiFailure(message: "Failed to fetch exam seats");
//     when(() => mockRepository.getAllExamSeat())
//         .thenAnswer((_) async => Left(failure));

//     // Act
//     final result = await usecase();

//     // Assert
//     expect(result, Left(failure));
//     verify(() => mockRepository.getAllExamSeat()).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });
// }

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
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
    ExamSeatEntity(examSeatId: "1", seatNumber: 'A1', booked: false),
    ExamSeatEntity(examSeatId: "2", seatNumber: 'B2', booked: true),
  ];

  test('✅ should get all exam seats from repository', () async {
    // Arrange
    when(() => mockRepository.getAllExamSeat())
        .thenAnswer((_) async => Right(examSeats));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(examSeats));
    verify(() => mockRepository.getAllExamSeat()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  // // ✅ Test 2: Should return an empty list if no seats are available
  // test('✅ should return an empty list if no exam seats are available',
  //     () async {
  //   // Arrange
  //   when(() => mockRepository.getAllExamSeat())
  //       .thenAnswer((_) async => Right([]));

  //   // Act
  //   final result = await usecase();

  //   // Assert
  //   expect(result, Right([]));
  //   verify(() => mockRepository.getAllExamSeat()).called(1);
  // });

  // ✅ Test 3: Should return an ApiFailure when repository fails
  test('✅ should return a Failure when repository fails to get exam seats',
      () async {
    // Arrange
    final failure = ApiFailure(message: "Failed to fetch exam seats");
    when(() => mockRepository.getAllExamSeat())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getAllExamSeat()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  // ✅ Test 4: Should handle an unexpected exception gracefully
  // test('✅ should handle unexpected exceptions', () async {
  //   // Arrange
  //   when(() => mockRepository.getAllExamSeat())
  //       .thenThrow(Exception("Unexpected error"));

  //   // Act
  //   final result = await usecase();

  //   // Assert
  //   expect(result, isA<Left<Failure, List<ExamSeatEntity>>>());
  //   expect((result as Left).value, isA<ApiFailure>());
  //   verify(() => mockRepository.getAllExamSeat()).called(1);
  // });

  // ✅ Test 5: Should verify `getAllExamSeat()` is only called once
  test('✅ should ensure getAllExamSeat() is called only once', () async {
    // Arrange
    when(() => mockRepository.getAllExamSeat())
        .thenAnswer((_) async => Right(examSeats));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(examSeats));
    verify(() => mockRepository.getAllExamSeat()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  // ✅ Test 6: Should return a list with mixed booked and unbooked seats
  test('✅ should return a list containing both booked and unbooked seats',
      () async {
    // Arrange
    final mixedSeats = [
      ExamSeatEntity(examSeatId: "3", seatNumber: 'C3', booked: false),
      ExamSeatEntity(examSeatId: "4", seatNumber: 'D4', booked: true),
    ];
    when(() => mockRepository.getAllExamSeat())
        .thenAnswer((_) async => Right(mixedSeats));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(mixedSeats));
    expect((result as Right).value[0].booked, false);
    expect((result as Right).value[1].booked, true);
    verify(() => mockRepository.getAllExamSeat()).called(1);
  });
}
