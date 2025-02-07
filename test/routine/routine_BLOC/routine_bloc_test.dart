// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/routine/domain/use%20_case/get_all_routine.dart';

// import 'routine_usecase.mock.dart';


// void main() {
//   late MockGetRoutineUsecase mockGetRoutineUsecase;
//   late RoutineBloc routineBloc;

//   setUp(() {
//     mockGetRoutineUsecase = MockGetRoutineUsecase();
//     routineBloc = RoutineBloc(mockGetRoutineUsecase);
//   });

//   group('RoutineBloc', () {
//     final List<RoutineEntity> mockRoutines = [
//       RoutineEntity(day: 'Monday', time: '9:00 AM', subject: 'Math', type: 'Lecture'),
//       RoutineEntity(day: 'Tuesday', time: '11:00 AM', subject: 'English', type: 'Tutorial'),
//     ];

//     test('initial state should be RoutineInitial', () {
//       // Assert the initial state is RoutineInitial
//       expect(routineBloc.state, equals(RoutineInitial()));
//     });

//     blocTest<RoutineBloc, RoutineState>(
//       'emits [RoutineLoading, RoutineLoaded] when GetAllRoutines succeeds',
//       build: () {
//         // When GetAllRoutines is called, it returns a success (Right) with mock data
//         when(mockGetRoutineUsecase.call()).thenAnswer((_) async => Right(mockRoutines));
//         return routineBloc;
//       },
//       act: (bloc) => bloc.add(FetchAllRoutinesEvent()),
//       expect: () => [
//         RoutineLoading(),
//         RoutineLoaded(mockRoutines),
//       ],
//     );

//     blocTest<RoutineBloc, RoutineState>(
//       'emits [RoutineLoading, RoutineError] when GetAllRoutines fails',
//       build: () {
//         // When GetAllRoutines is called, it returns a failure (Left) with an error message
//         when(mockGetRoutineUsecase.call()).thenAnswer((_) async => Left(Failure('Error fetching routines')));
//         return routineBloc;
//       },
//       act: (bloc) => bloc.add(FetchAllRoutinesEvent()),
//       expect: () => [
//         RoutineLoading(),
//         RoutineError('Error fetching routines'),
//       ],
//     );
//   });
// }
