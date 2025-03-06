import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/book_seat.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/get_all_seat.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/unbook_seat.dart';

// ✅ Mock Use Cases
class MockGetAllSeat extends Mock implements GetAllSeat {}

class MockBookSeat extends Mock implements BookSeat {}

class MockUnbookSeat extends Mock implements UnbookSeat {}

void main() {
  late ExamSeatBloc examSeatBloc;
  late MockGetAllSeat mockGetAllSeat;
  late MockBookSeat mockBookSeat;
  late MockUnbookSeat mockUnbookSeat;

  setUp(() {
    mockGetAllSeat = MockGetAllSeat();
    mockBookSeat = MockBookSeat();
    mockUnbookSeat = MockUnbookSeat();
    examSeatBloc = ExamSeatBloc(
      getAllSeat: mockGetAllSeat,
      bookSeat: mockBookSeat,
      unbookSeat: mockUnbookSeat,
    );

    registerFallbackValue(ExamSeatEvent);
  });

  tearDown(() {
    examSeatBloc.close();
  });

  final List<ExamSeatEntity> testSeats = [
    ExamSeatEntity(examSeatId: "1", seatNumber: "A1", booked: false),
    ExamSeatEntity(examSeatId: "2", seatNumber: "B2", booked: true),
  ];

  final ExamSeatEntity bookedSeat =
      ExamSeatEntity(examSeatId: "1", seatNumber: "A1", booked: true);
  final ExamSeatEntity unbookedSeat =
      ExamSeatEntity(examSeatId: "2", seatNumber: "B2", booked: false);

  // ✅ Test 1: Fetch all exam seats successfully
  blocTest<ExamSeatBloc, ExamSeatState>(
    'emits [ExamSeatLoading, ExamSeatLoaded] when GetExamSeatsEvent is successful',
    build: () {
      when(() => mockGetAllSeat.call())
          .thenAnswer((_) async => Right(testSeats));
      return examSeatBloc;
    },
    act: (bloc) => bloc.add(GetExamSeatsEvent()),
    expect: () => [
      ExamSeatLoading(),
      ExamSeatLoaded(seats: testSeats, selectedSeatId: null),
    ],
    verify: (_) {
      verify(() => mockGetAllSeat.call()).called(1);
    },
  );

  // ✅ Test 2: Handle failure when fetching seats
  blocTest<ExamSeatBloc, ExamSeatState>(
    'emits [ExamSeatLoading, ExamSeatError] when GetExamSeatsEvent fails',
    build: () {
      when(() => mockGetAllSeat.call()).thenAnswer(
          (_) async => Left(ApiFailure(message: "Failed to fetch seats")));
      return examSeatBloc;
    },
    act: (bloc) => bloc.add(GetExamSeatsEvent()),
    expect: () => [
      ExamSeatLoading(),
      ExamSeatError("Failed to fetch seats"),
    ],
    verify: (_) {
      verify(() => mockGetAllSeat.call()).called(1);
    },
  );

  // ✅ Test 3: Booking a seat successfully
  blocTest<ExamSeatBloc, ExamSeatState>(
    'emits [ExamSeatLoading, ExamSeatLoaded] when BookExamSeatEvent is successful',
    build: () {
      when(() => mockBookSeat.call("1"))
          .thenAnswer((_) async => Right(bookedSeat));
      return examSeatBloc;
    },
    seed: () => ExamSeatLoaded(seats: testSeats, selectedSeatId: null),
    act: (bloc) => bloc.add(const BookExamSeatEvent("1")),
    expect: () => [
      ExamSeatLoading(),
      ExamSeatLoaded(seats: [
        bookedSeat,
        testSeats[1], // Keep other seats unchanged
      ], selectedSeatId: "1"),
    ],
    verify: (_) {
      verify(() => mockBookSeat.call("1")).called(1);
    },
  );

  // ✅ Test 4: Handle failure when booking a seat
  blocTest<ExamSeatBloc, ExamSeatState>(
    'emits [ExamSeatLoading, ExamSeatError] when BookExamSeatEvent fails',
    build: () {
      when(() => mockBookSeat.call("1")).thenAnswer(
          (_) async => Left(ApiFailure(message: "Failed to book seat")));
      return examSeatBloc;
    },
    seed: () => ExamSeatLoaded(seats: testSeats, selectedSeatId: null),
    act: (bloc) => bloc.add(const BookExamSeatEvent("1")),
    expect: () => [
      ExamSeatLoading(),
      ExamSeatError("Failed to book seat"),
    ],
    verify: (_) {
      verify(() => mockBookSeat.call("1")).called(1);
    },
  );

  // ✅ Test 5: Unbooking a seat successfully
  blocTest<ExamSeatBloc, ExamSeatState>(
    'emits [ExamSeatLoading, ExamSeatLoaded] when UnbookExamSeatEvent is successful',
    build: () {
      when(() => mockUnbookSeat.call("2"))
          .thenAnswer((_) async => Right(unbookedSeat));
      return examSeatBloc;
    },
    seed: () => ExamSeatLoaded(seats: testSeats, selectedSeatId: "2"),
    act: (bloc) => bloc.add(const UnbookExamSeatEvent("2")),
    expect: () => [
      ExamSeatLoading(),
      ExamSeatLoaded(seats: [
        testSeats[0], // Keep other seats unchanged
        unbookedSeat,
      ], selectedSeatId: null),
    ],
    verify: (_) {
      verify(() => mockUnbookSeat.call("2")).called(1);
    },
  );

  // ✅ Test 6: Handle failure when unbooking a seat
  blocTest<ExamSeatBloc, ExamSeatState>(
    'emits [ExamSeatLoading, ExamSeatError] when UnbookExamSeatEvent fails',
    build: () {
      when(() => mockUnbookSeat.call("2")).thenAnswer(
          (_) async => Left(ApiFailure(message: "Failed to unbook seat")));
      return examSeatBloc;
    },
    seed: () => ExamSeatLoaded(seats: testSeats, selectedSeatId: "2"),
    act: (bloc) => bloc.add(const UnbookExamSeatEvent("2")),
    expect: () => [
      ExamSeatLoading(),
      ExamSeatError("Failed to unbook seat"),
    ],
    verify: (_) {
      verify(() => mockUnbookSeat.call("2")).called(1);
    },
  );
}
