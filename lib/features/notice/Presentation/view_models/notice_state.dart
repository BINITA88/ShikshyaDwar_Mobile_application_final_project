part of 'notice_bloc.dart';

class NoticeState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<NoticeEntity> message; // Store fetched notices

  const NoticeState({
    required this.isLoading,
    required this.isSuccess,
    required this.message,
  });

  factory NoticeState.initial() {
    return const NoticeState(
      isLoading: false,
      isSuccess: false,
      message: [],
    );
  }

  NoticeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<NoticeEntity>? notices,
  }) {
    return NoticeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: notices ?? this.message,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, message];
}
