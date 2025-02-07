// MockNoticeBlocTest.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/view_models/notice_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/view_models/notice_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';

import 'get_all_notice_usecase.mock.dart';

void main() {
  late GetAllNoticeUsecase getAllNoticeUsecase;
  late NoticeBloc noticeBloc;

  // Mock data for notice entities
  const noticeList = [
    NoticeEntity(
      noticeId: "1",
      message: '',
    ),
    NoticeEntity(
      noticeId: "2",
      message: '',
    ),
  ];

  // Set up before each test
  setUp(() {
    getAllNoticeUsecase = MockGetAllNoticeUseCase();
    noticeBloc = NoticeBloc(getAllNoticeUsecase: getAllNoticeUsecase);
  });

  // Test for initial state
  test('initial state should be NoticeState.initial()', () {
    expect(noticeBloc.state, NoticeState.initial());
  });

  // Test when notices are fetched successfully
  blocTest<NoticeBloc, NoticeState>(
    'should emit [loading, success] when notices are fetched successfully',
    build: () {
      // Mock the use case to return a successful response
      when(() => getAllNoticeUsecase()).thenAnswer(
        (_) async => Right(noticeList),
      );
      return noticeBloc;
    },
    act: (bloc) => bloc.add(LoadNoticeEvent()),
    expect: () => [
      NoticeState(isLoading: true, isSuccess: false, message: []),
      NoticeState(isLoading: false, isSuccess: true, message: []),
    ],
    verify: (_) {
      // Verify that the use case was called once
      verify(() => getAllNoticeUsecase()).called(1);
    },
  );

  // Test when fetching notices fails
  blocTest<NoticeBloc, NoticeState>(
    'should emit [loading, failure] when notices fetching fails',
    build: () {
      // Mock the use case to return a failure response
      when(() => getAllNoticeUsecase()).thenAnswer(
        (_) async => Left(ApiFailure(message: 'Failed to fetch notices')),
      );
      return noticeBloc;
    },
    act: (bloc) => bloc.add(LoadNoticeEvent()),
    expect: () => [
      const NoticeState(isLoading: true, isSuccess: false, message: []),
      const NoticeState(
        isLoading: false,
        isSuccess: false,
        message: [],
      ),
    ],
  );

  // Test when notices are empty
  blocTest<NoticeBloc, NoticeState>(
    'should emit [loading, success] with empty list when no notices are found',
    build: () {
      // Mock the use case to return an empty list
      when(() => getAllNoticeUsecase()).thenAnswer((_) async => Right([]));
      return noticeBloc;
    },
    act: (bloc) => bloc.add(LoadNoticeEvent()),
    expect: () => [
      NoticeState(isLoading: true, isSuccess: false, message: []),
      NoticeState(
        isLoading: false,
        isSuccess: true,
        message: [],
      ),
    ],
  );

  // Test when an unexpected error occurs
}
