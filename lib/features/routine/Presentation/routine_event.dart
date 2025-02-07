import 'package:equatable/equatable.dart';

abstract class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoutinesEvent extends RoutineEvent {}