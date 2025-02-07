// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';

// import '../routine_bloc/routine_usecase.mock.dart';


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
//       expect(routineBloc.state, equals(RoutineInitial()));
//     });

//     blocTest<RoutineBloc, RoutineState>(
//       'emits [RoutineLoading, RoutineLoaded] when GetAllRoutines is called successfully',
//       build: () {
//         when(() => mockGetRoutineUsecase.call()).thenAnswer((_) async => Right(mockRoutines));
//         return routineBloc;
//       },
//       act: (bloc) => bloc.add(FetchAllRoutinesEvent()),
//       expect: () => [
//         RoutineLoading(),
//         RoutineLoaded(mockRoutines),
//       ],
//       verify: (_) {
//         verify(() => mockGetRoutineUsecase.call()).called(1);
//       },
//     );

//     blocTest<RoutineBloc, RoutineState>(
//       'emits [RoutineLoading, RoutineError] when GetAllRoutines fails',
//       build: () {
//         when(() => mockGetRoutineUsecase.call()).thenAnswer((_) async => Left(Failure('Error')));
//         return routineBloc;
//       },
//       act: (bloc) => bloc.add(FetchAllRoutinesEvent()),
//       expect: () => [
//         RoutineLoading(),
//         RoutineError('Error'),
//       ],
//       verify: (_) {
//         verify(() => mockGetRoutineUsecase.call()).called(1);
//       },
//     );
//   });
// }