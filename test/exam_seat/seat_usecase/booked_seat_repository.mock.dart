import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/book_seat.dart';

// Mock Repository
class MockExamsSeatRepository extends Mock implements IExamSeatRepository {}

// Mock Use Cases
class MockBookSeat extends Mock implements BookSeat {}
