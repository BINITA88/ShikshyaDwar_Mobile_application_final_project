import 'package:equatable/equatable.dart';

class VerifyState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const VerifyState({
    required this.isLoading,
    required this.isSuccess,
  });

  // Initial state
  factory VerifyState.initial() =>
      const VerifyState(isLoading: false, isSuccess: false);

  // CopyWith method to update state immutably
  VerifyState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return VerifyState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object> get props => [isLoading, isSuccess];
}
