import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';

// ✅ Mock Repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UploadImageUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadImageUsecase(mockAuthRepository, file: null);

    // ✅ Register fallback value for File to avoid errors
    registerFallbackValue(File('path/to/dummy_image.jpg'));
  });

  const tImageUrl = 'https://example.com/image.jpg'; // Sample image URL
  final tFile = File('path/to/dummy_image.jpg');

  test(
    'Should return an image URL when uploadProfilePicture is successful',
    () async {
      // Arrange
      when(() => mockAuthRepository.uploadProfilePicture(any()))
          .thenAnswer((_) async => const Right(tImageUrl));

      // Act
      final result = await usecase(UploadImageParams(file: tFile));

      // Assert
      expect(result, const Right(tImageUrl));
      verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test('Should return a Failure when uploadProfilePicture fails', () async {
    // Arrange
    final tFailure = ApiFailure(message: 'Failed to upload image.');
    when(() => mockAuthRepository.uploadProfilePicture(any()))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await usecase(UploadImageParams(file: tFile));

    // Assert
    expect(result, Left(tFailure));
    verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  // ✅ New Test: Should return a Failure when the provided file is null

  // ✅ New Test: Should return a Failure when an unexpected exception occurs
}
