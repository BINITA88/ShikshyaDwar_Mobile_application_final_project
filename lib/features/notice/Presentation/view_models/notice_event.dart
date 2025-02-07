import 'package:equatable/equatable.dart';

sealed class NoticeEvent extends Equatable {
  const NoticeEvent();

  @override
  List<Object> get props => [];
}

class LoadNoticeEvent extends NoticeEvent {}
