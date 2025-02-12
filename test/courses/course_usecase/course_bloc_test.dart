// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';

// // ✅ Import the Correct Mock File
// import 'mock_get_all_courses_usecases.dart';

// void main() {
//   late MockGetAllCoursesUseCase getAllCourseUsecase;
//   late CourseBloc courseBloc;

//   // Mock data for course entities
//   const courseList = [
//     CourseEntity(
//       courseId: "1",
//       courseName: "Flutter Development",
//       coursePrice: 199.99,
//       instructor: "John Doe",
//       courseImage: "https://example.com/flutter.jpg",
//       duration: "3 months",
//       courseDescription: "Learn Flutter from scratch",
//       category: "Programming",
//     ),
//     CourseEntity(
//       courseId: "2",
//       courseName: "React Development",
//       coursePrice: 149.99,
//       instructor: "Jane Smith",
//       courseImage: "https://example.com/react.jpg",
//       duration: "2 months",
//       courseDescription: "Master React with hands-on projects",
//       category: "Web Development",
//     ),
//   ];

//   setUpAll(() {
//     registerFallbackValue(LoadCoursesEvent()); // Register fallback event
//   });

//   setUp(() {
//     getAllCourseUsecase = MockGetAllCoursesUseCase();
//     courseBloc = CourseBloc(getAllCourseUsecase: getAllCourseUsecase);
//   });

//   tearDown(() {
//     courseBloc.close(); // Close bloc to avoid memory leaks
//   });

//   // Test for initial state
//   test('Initial state should be CourseState.initial()', () {
//     expect(courseBloc.state, CourseState.initial());
//   });

//   // Test when courses are fetched successfully
//   blocTest<CourseBloc, CourseState>(
//     'should emit [loading, success] when courses are fetched successfully',
//     build: () {
//       when(() => getAllCourseUsecase()).thenAnswer(
//         (_) async => Right(courseList),
//       );
//       return courseBloc;
//     },
//     act: (bloc) => bloc.add(LoadCoursesEvent()),
//     expect: () => [
//       CourseState(isLoading: true, isSuccess: false, courses: []),
//       CourseState(isLoading: false, isSuccess: true, courses: courseList),
//     ],
//     verify: (_) {
//       verify(() => getAllCourseUsecase()).called(1);
//     },
//   );

//   // Test when fetching courses fails
//   blocTest<CourseBloc, CourseState>(
//     'should emit [loading, failure] when courses fetching fails',
//     build: () {
//       when(() => getAllCourseUsecase()).thenAnswer(
//         (_) async => Left(ApiFailure(message: 'Failed to fetch courses')),
//       );
//       return courseBloc;
//     },
//     act: (bloc) => bloc.add(LoadCoursesEvent()),
//     expect: () => [
//       CourseState(isLoading: true, isSuccess: false, courses: []),
//       CourseState(
//         isLoading: false,
//         isSuccess: false,
//         courses: [],
//       ),
//     ],
//     verify: (_) {
//       verify(() => getAllCourseUsecase()).called(1);
//     },
//   );

//   // Test when courses are empty
//   blocTest<CourseBloc, CourseState>(
//     'should emit [loading, success] with empty list when no courses are found',
//     build: () {
//       when(() => getAllCourseUsecase()).thenAnswer((_) async => Right([]));
//       return courseBloc;
//     },
//     act: (bloc) => bloc.add(LoadCoursesEvent()),
//     expect: () => [
//       CourseState(isLoading: true, isSuccess: false, courses: []),
//       CourseState(isLoading: false, isSuccess: true, courses: []),
//     ],
//   );

//   // Test when an unexpected error occurs
//   blocTest<CourseBloc, CourseState>(
//     'should emit [loading, failure] when an unexpected error occurs',
//     build: () {
//       when(() => getAllCourseUsecase())
//           .thenThrow(Exception('Unexpected error'));
//       return courseBloc;
//     },
//     act: (bloc) => bloc.add(LoadCoursesEvent()),
//     errors: () => [isA<Exception>()],
//   );
// }
