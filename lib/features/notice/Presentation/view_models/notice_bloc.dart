import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/Notice/domain/entity/notice_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/view_models/notice_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';

part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final GetAllNoticeUsecase _getAllNoticeUsecase;

  NoticeBloc({required GetAllNoticeUsecase getAllNoticeUsecase})
      : _getAllNoticeUsecase = getAllNoticeUsecase,
        super(NoticeState.initial()) {
    on<LoadNoticeEvent>(_onLoadNotices);
  }

  Future<void> _onLoadNotices(
      LoadNoticeEvent event, Emitter<NoticeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllNoticeUsecase();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (notices) => emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        notices: [], // Store fetched notices
      )),
    );
  }
}
