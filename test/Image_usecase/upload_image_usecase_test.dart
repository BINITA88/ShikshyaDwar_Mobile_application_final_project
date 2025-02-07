import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';

import '../register/register_usecase/auth_repository.mock.dart';

void main() {
  late UploadImageUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadImageUsecase(mockAuthRepository,
        file: null); // Initialize with null file
  });

  const tImageUrl = 'https://example.com/image.jpg'; // Sample image URL
  final tFile = File('path/to/dummy_image.jpg');

  test(
    'Should return an image URL when uploadProfilePicture is successful',
    () async {
      // Arrange: Setup the mock to return a Right(tImageUrl)
      when(() => mockAuthRepository.uploadProfilePicture(tFile))
          .thenAnswer((_) async => const Right(tImageUrl));

      // Act: Call the use case
      final result = await usecase(UploadImageParams(file: tFile));

      // Assert: Check if the result is Right(tImageUrl)
      expect(result, const Right(tImageUrl));

      // Verify that the repository method was called with the correct File
      verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);

      // Ensure no other interactions occurred with the repository
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test('Should return a Failure when uploadProfilePicture fails', () async {
    // Arrange: Setup the mock to return a Left(ServerFailure)
    final tFailure = ApiFailure(message: 'Failed to upload image.');
    when(() => mockAuthRepository.uploadProfilePicture(tFile))
        .thenAnswer((_) async => Left(tFailure));

    // Act: Call the use case
    final result = await usecase(UploadImageParams(file: tFile));

    // Assert: Check if the result is Left(ServerFailure)
    expect(result, Left(tFailure));

    // Verify that the repository method was called with the correct File
    verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);

    // Ensure no other interactions occurred with the repository
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
