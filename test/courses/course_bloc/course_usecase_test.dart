// import 'dart:math';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/getAll_course_usecase.dart';

// // Mock the ICourseRepository
// class MockCourseRepository extends Mock implements ICourseRepository {}

// void main() {
//   late MockCourseRepository mockCourseRepository;
//   late GetAllCourseUsecase getAllCourseUsecase;

//   setUp(() {
//     mockCourseRepository = MockCourseRepository();
//     getAllCourseUsecase = GetAllCourseUsecase(mockCourseRepository);
//   });

//   group('GetAllCourseUsecase', () {
//     final List<CourseEntity> mockCourses = [
//       CourseEntity(
//         courseId: '1',
//         courseName: 'IELTS',
//         coursePrice: 199.99,
//         instructor: 'John Doe',
//         courseImage: 'image_url',
//         duration: '2 months',
//         courseDescription: 'Learn IELTS exam techniques.',
//         category: 'English Language',
//       ),
//       CourseEntity(
//         courseId: '2',
//         courseName: 'PTE',
//         coursePrice: 149.99,
//         instructor: 'Jane Smith',
//         courseImage: 'image_url',
//         duration: '1 month',
//         courseDescription: 'Prepare for the PTE exam.',
//         category: 'English Language',
//       ),
//     ];

//     test(
//         'should return a list of CourseEntity when the repository call is successful',
//         () async {
//       // Arrange
//       when(() => mockCourseRepository.getAllCourses())
//           .thenAnswer((_) async => Right(mockCourses));

//       // Act
//       final result = await getAllCourseUsecase();

//       // Assert
//       expect(result, equals(Right(mockCourses)));
//       verify(() => mockCourseRepository.getAllCourses()).called(1);
//     });

//     test('should return a failure when the repository call fails', () async {
//       // Arrange
//       final failure = (ApiFailure(message: e.toString()));
//       when(() => mockCourseRepository.getAllCourses())
//           .thenAnswer((_) async => Left(failure));

//       // Act
//       final result = await getAllCourseUsecase();

//       // Assert
//       expect(result, equals(Left(failure)));
//       verify(() => mockCourseRepository.getAllCourses()).called(1);
//     });
//   });
// }
