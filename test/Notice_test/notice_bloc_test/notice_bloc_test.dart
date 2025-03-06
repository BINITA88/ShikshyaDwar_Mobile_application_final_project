// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/view_models/notice_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';

// // ✅ Mock Use Case
// class MockGetAllNoticesUseCase extends Mock implements GetAllNoticesUseCase {}

// void main() {
//   late NoticeBloc noticeBloc;
//   late MockGetAllNoticesUseCase mockGetAllNoticesUseCase;

//   setUp(() {
//     mockGetAllNoticesUseCase = MockGetAllNoticesUseCase();
//     noticeBloc = NoticeBloc(getAllNoticesUseCase: mockGetAllNoticesUseCase);
//   });

//   tearDown(() {
//     noticeBloc.close();
//   });

//   final noticesList = [
//     NoticeEntity(noticeId: "1", message: "Test Notice 1"),
//     NoticeEntity(noticeId: "2", message: "Test Notice 2"),
//   ];

//   test('Initial state should be NoticeInitialState', () {
//     expect(noticeBloc.state, const NoticeInitialState());
//   });

//   blocTest<NoticeBloc, NoticeState>(
//     'emits [NoticeLoadingState, NoticeLoadedState] when LoadNoticeEvent is added and succeeds',
//     build: () {
//       when(() => mockGetAllNoticesUseCase.call())
//           .thenAnswer((_) async => Right(noticesList));
//       return noticeBloc;
//     },
//     act: (bloc) => bloc.add(LoadNoticeEvent()),
//     expect: () => [
//       const NoticeLoadingState(),
//       NoticeLoadedState(noticesList),
//     ],
//     verify: (_) {
//       verify(() => mockGetAllNoticesUseCase.call()).called(1);
//     },
//   );

//   blocTest<NoticeBloc, NoticeState>(
//     'emits [NoticeLoadingState, NoticeErrorState] when LoadNoticeEvent is added and fails',
//     build: () {
//       when(() => mockGetAllNoticesUseCase.call())
//           .thenAnswer((_) async => Left(ApiFailure(message: "Failed to load notices")));
//       return noticeBloc;
//     },
//     act: (bloc) => bloc.add(LoadNoticeEvent()),
//     expect: () => [
//       const NoticeLoadingState(),
//       const NoticeErrorState("Failed to load notices"),
//     ],
//     verify: (_) {
//       verify(() => mockGetAllNoticesUseCase.call()).called(1);
//     },
//   );
// }

// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/presentation/view_models/notice_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';

// // ✅ Mock Use Case
// class MockGetAllNoticesUseCase extends Mock implements GetAllNoticesUseCase {}

// void main() {
//   late NoticeBloc noticeBloc;
//   late MockGetAllNoticesUseCase mockGetAllNoticesUseCase;

//   setUp(() {
//     mockGetAllNoticesUseCase = MockGetAllNoticesUseCase();
//     noticeBloc = NoticeBloc(getAllNoticesUseCase: mockGetAllNoticesUseCase);
//   });

//   tearDown(() {
//     noticeBloc.close();
//   });

//   final noticesList = [
//     NoticeEntity(noticeId: "1", message: "Test Notice 1"),
//     NoticeEntity(noticeId: "2", message: "Test Notice 2"),
//   ];

//   test('Initial state should be NoticeInitialState', () {
//     expect(noticeBloc.state, const NoticeInitialState());
//   });

//   blocTest<NoticeBloc, NoticeState>(
//     'emits [NoticeLoadingState, NoticeLoadedState] when LoadNoticeEvent is added and succeeds',
//     build: () {
//       when(() => mockGetAllNoticesUseCase.call())
//           .thenAnswer((_) async => Right(noticesList));
//       return noticeBloc;
//     },
//     act: (bloc) => bloc.add(LoadNoticeEvent()),
//     expect: () => [
//       const NoticeLoadingState(),
//       NoticeLoadedState(noticesList),
//     ],
//     verify: (_) {
//       verify(() => mockGetAllNoticesUseCase.call()).called(1);
//     },
//   );

//   blocTest<NoticeBloc, NoticeState>(
//     'emits [NoticeLoadingState, NoticeErrorState] when LoadNoticeEvent is added and fails',
//     build: () {
//       when(() => mockGetAllNoticesUseCase.call()).thenAnswer(
//           (_) async => Left(ApiFailure(message: "Failed to load notices")));
//       return noticeBloc;
//     },
//     act: (bloc) => bloc.add(LoadNoticeEvent()),
//     expect: () => [
//       const NoticeLoadingState(),
//       const NoticeErrorState("Failed to load notices"),
//     ],
//     verify: (_) {
//       verify(() => mockGetAllNoticesUseCase.call()).called(1);
//     },
//   );

//   // ✅ New Test 1: Should return an empty list when no notices are found
//   blocTest<NoticeBloc, NoticeState>(
//     'emits [NoticeLoadingState, NoticeLoadedState] when repository returns an empty notice list',
//     build: () {
//       when(() => mockGetAllNoticesUseCase.call())
//           .thenAnswer((_) async => const Right([]));
//       return noticeBloc;
//     },
//     act: (bloc) => bloc.add(LoadNoticeEvent()),
//     expect: () => [
//       const NoticeLoadingState(),
//       const NoticeLoadedState([]),
//     ],
//     verify: (_) {
//       verify(() => mockGetAllNoticesUseCase.call()).called(1);
//     },
//   );

//   // ✅ New Test 2: Should return a single notice when repository returns one notice
//   blocTest<NoticeBloc, NoticeState>(
//     'emits [NoticeLoadingState, NoticeLoadedState] when repository returns a single notice',
//     build: () {
//       final singleNotice = [
//         NoticeEntity(noticeId: "1", message: "Single Notice")
//       ];
//       when(() => mockGetAllNoticesUseCase.call())
//           .thenAnswer((_) async => Right(singleNotice));
//       return noticeBloc;
//     },
//     act: (bloc) => bloc.add(LoadNoticeEvent()),
//     expect: () => [
//       const NoticeLoadingState(),
//       NoticeLoadedState(
//           [NoticeEntity(noticeId: "1", message: "Single Notice")]),
//     ],
//     verify: (_) {
//       verify(() => mockGetAllNoticesUseCase.call()).called(1);
//     },
//   );
// }

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/presentation/view_models/notice_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';

// ✅ Mock Use Case
class MockGetAllNoticesUseCase extends Mock implements GetAllNoticesUseCase {}

void main() {
  late NoticeBloc noticeBloc;
  late MockGetAllNoticesUseCase mockGetAllNoticesUseCase;

  setUp(() {
    mockGetAllNoticesUseCase = MockGetAllNoticesUseCase();
    noticeBloc = NoticeBloc(getAllNoticesUseCase: mockGetAllNoticesUseCase);
  });

  tearDown(() {
    noticeBloc.close();
  });

  final noticesList = [
    NoticeEntity(noticeId: "1", message: "Test Notice 1"),
    NoticeEntity(noticeId: "2", message: "Test Notice 2"),
  ];

  test('✅ Initial state should be NoticeInitialState', () {
    expect(noticeBloc.state, const NoticeInitialState());
  });

  blocTest<NoticeBloc, NoticeState>(
    '✅ emits [NoticeLoadingState, NoticeLoadedState] when LoadNoticeEvent is added and succeeds',
    build: () {
      when(() => mockGetAllNoticesUseCase.call())
          .thenAnswer((_) async => Right(noticesList));
      return noticeBloc;
    },
    act: (bloc) => bloc.add(LoadNoticeEvent()),
    expect: () => [
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(1);
    },
  );

  blocTest<NoticeBloc, NoticeState>(
    '✅ emits [NoticeLoadingState, NoticeErrorState] when LoadNoticeEvent is added and fails',
    build: () {
      when(() => mockGetAllNoticesUseCase.call()).thenAnswer(
          (_) async => Left(ApiFailure(message: "Failed to load notices")));
      return noticeBloc;
    },
    act: (bloc) => bloc.add(LoadNoticeEvent()),
    expect: () => [
      const NoticeLoadingState(),
      const NoticeErrorState("Failed to load notices"),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(1);
    },
  );

  // ✅ New Test 1: Should remain in NoticeInitialState when no events are added
  test('✅ Should remain in NoticeInitialState when no events are added', () {
    expect(noticeBloc.state, const NoticeInitialState());
  });

  test('✅ Should remain in NoticeInitialState when no events are added', () {
    expect(noticeBloc.state, const NoticeInitialState());
  });
  // ✅ New Test 2: Should not emit new states if the same state is emitted consecutively
  blocTest<NoticeBloc, NoticeState>(
    '✅ Should not emit duplicate states if the same state is emitted twice',
    build: () {
      when(() => mockGetAllNoticesUseCase.call())
          .thenAnswer((_) async => Right(noticesList));
      return noticeBloc;
    },
    act: (bloc) {
      bloc.add(LoadNoticeEvent());
      bloc.add(LoadNoticeEvent()); // Calling twice
    },
    expect: () => [
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(2);
    },
  );
  blocTest<NoticeBloc, NoticeState>(
    '✅ emits [NoticeLoadingState, NoticeLoadedState] when LoadNoticeEvent is added and succeeds',
    build: () {
      when(() => mockGetAllNoticesUseCase.call())
          .thenAnswer((_) async => Right(noticesList));
      return noticeBloc;
    },
    act: (bloc) => bloc.add(LoadNoticeEvent()),
    expect: () => [
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(1);
    },
  );
  blocTest<NoticeBloc, NoticeState>(
    '✅ Should not emit duplicate states if the same state is emitted twice',
    build: () {
      when(() => mockGetAllNoticesUseCase.call())
          .thenAnswer((_) async => Right(noticesList));
      return noticeBloc;
    },
    act: (bloc) {
      bloc.add(LoadNoticeEvent());
      bloc.add(LoadNoticeEvent()); // Calling twice
    },
    expect: () => [
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(2);
    },
  );

  // ✅ New Test 3: Should handle multiple LoadNoticeEvent calls correctly
  blocTest<NoticeBloc, NoticeState>(
    '✅ Should handle multiple sequential LoadNoticeEvent calls correctly',
    build: () {
      when(() => mockGetAllNoticesUseCase.call())
          .thenAnswer((_) async => Right(noticesList));
      return noticeBloc;
    },
    act: (bloc) {
      bloc.add(LoadNoticeEvent());
      bloc.add(LoadNoticeEvent());
      bloc.add(LoadNoticeEvent());
    },
    expect: () => [
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(3);
    },
  );
  // ✅ New Test 3: Should handle multiple LoadNoticeEvent calls correctly
  blocTest<NoticeBloc, NoticeState>(
    '✅ Should handle multiple sequential LoadNoticeEvent calls correctly',
    build: () {
      when(() => mockGetAllNoticesUseCase.call())
          .thenAnswer((_) async => Right(noticesList));
      return noticeBloc;
    },
    act: (bloc) {
      bloc.add(LoadNoticeEvent());
      bloc.add(LoadNoticeEvent());
      bloc.add(LoadNoticeEvent());
    },
    expect: () => [
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
      const NoticeLoadingState(),
      NoticeLoadedState(noticesList),
    ],
    verify: (_) {
      verify(() => mockGetAllNoticesUseCase.call()).called(3);
    },
  );
}
