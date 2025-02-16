import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';

// ✅ Define Notice Events
abstract class NoticeEvent extends Equatable {
  const NoticeEvent();
  @override
  List<Object> get props => [];
}

class LoadNoticeEvent extends NoticeEvent {}

// ✅ Define Notice States
abstract class NoticeState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<NoticeEntity> notices;
  final String? errorMessage;

  const NoticeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.notices = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, isSuccess, notices, errorMessage];
}

// ✅ Initial State
class NoticeInitialState extends NoticeState {
  const NoticeInitialState();
}

// ✅ Loading State
class NoticeLoadingState extends NoticeState {
  const NoticeLoadingState() : super(isLoading: true);
}

// ✅ Loaded State (Success)
class NoticeLoadedState extends NoticeState {
  const NoticeLoadedState(List<NoticeEntity> notices)
      : super(isSuccess: true, notices: notices);
}

// ✅ Error State
class NoticeErrorState extends NoticeState {
  const NoticeErrorState(String errorMessage)
      : super(errorMessage: errorMessage);
}

// ✅ Notice Bloc
class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final GetAllNoticesUseCase getAllNoticesUseCase;

  NoticeBloc({required this.getAllNoticesUseCase})
      : super(const NoticeInitialState()) {
    on<LoadNoticeEvent>((event, emit) async {
      emit(const NoticeLoadingState());

      final result = await getAllNoticesUseCase.call();

      result.fold(
        (failure) {
          print(
              "❌ NoticeBloc Error: ${failure.message}"); // ✅ Debug API Failure
          emit(NoticeErrorState("Failed to load notices"));
        },
        (notices) {
          print("✅ Notices Loaded: $notices"); // ✅ Debug API Success
          emit(NoticeLoadedState(notices));
        },
      );
    });
  }
}
