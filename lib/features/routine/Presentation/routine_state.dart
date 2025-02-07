import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';

class RoutineState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<RoutineEntity> routines;
  final Failure? error;

  const RoutineState({
    required this.isLoading,
    required this.isSuccess,
    required this.routines,
    this.error,
  });

  factory RoutineState.initial() {
    return const RoutineState(
      isLoading: false,
      isSuccess: false,
      routines: [],
    );
  }

  RoutineState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<RoutineEntity>? routines,
    Failure? error,
  }) {
    return RoutineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      routines: routines ?? this.routines,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, routines, error];
}