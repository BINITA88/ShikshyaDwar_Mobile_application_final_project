import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/repository/notice_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';

// ✅ Mock Repository
class MockNoticeRepository extends Mock implements INoticeRepository {}

void main() {
  late GetAllNoticesUseCase useCase;
  late MockNoticeRepository mockNoticeRepository;

  setUp(() {
    mockNoticeRepository = MockNoticeRepository();
    useCase = GetAllNoticesUseCase(noticeRepository: mockNoticeRepository);
  });

  final noticesList = [
    NoticeEntity(noticeId: "1", message: "Test Notice 1"),
    NoticeEntity(noticeId: "2", message: "Test Notice 2"),
  ];

  test('should return a list of notices from repository', () async {
    // Arrange
    when(() => mockNoticeRepository.getAllNotice())
        .thenAnswer((_) async => Right(noticesList));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Right(noticesList));
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  test('should return a list of notices from repository', () async {
    // Arrange
    when(() => mockNoticeRepository.getAllNotice())
        .thenAnswer((_) async => Right(noticesList));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Right(noticesList));
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    final failure = ApiFailure(message: "Failed to load notices");
    when(() => mockNoticeRepository.getAllNotice())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Left(failure));
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    final failure = ApiFailure(message: "Failed to load notices");
    when(() => mockNoticeRepository.getAllNotice())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Left(failure));
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  // ✅ New Test 2: Should throw an unexpected exception when repository crashes
  test('should throw an unexpected exception when repository crashes',
      () async {
    // Arrange
    when(() => mockNoticeRepository.getAllNotice())
        .thenThrow(Exception("Unexpected error"));

    // Act
    expect(() async => await useCase.call(), throwsA(isA<Exception>()));

    // Assert
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  // ✅ New Test 3: Should return Failure when repository returns null (edge case)
  test('should return Failure when repository returns null (edge case)',
      () async {
    // Arrange
    when(() => mockNoticeRepository.getAllNotice()).thenAnswer((_) async =>
        Left(ApiFailure(message: "Null response from repository")));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, isA<Left<Failure, List<NoticeEntity>>>()); // Expect Failure
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  // ✅ New Test 4: Should return a single notice when repository returns only one
  test('should return a single notice when repository returns only one',
      () async {
    // Arrange
    final singleNotice = [
      NoticeEntity(noticeId: "1", message: "Single Notice")
    ];
    when(() => mockNoticeRepository.getAllNotice())
        .thenAnswer((_) async => Right(singleNotice));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Right(singleNotice));
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });

  // ✅ New Test 5: Should return Failure when API timeout occurs
  test('should return Failure when API timeout occurs', () async {
    // Arrange
    when(() => mockNoticeRepository.getAllNotice()).thenAnswer(
        (_) async => Left(ApiFailure(message: "API timeout occurred")));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Left(ApiFailure(message: "API timeout occurred")));
    verify(() => mockNoticeRepository.getAllNotice()).called(1);
    verifyNoMoreInteractions(mockNoticeRepository);
  });
}
