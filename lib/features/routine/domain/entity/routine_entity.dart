import 'package:equatable/equatable.dart';

enum RoutineStatus { active, cancelled, paused }

class RoutineEntity extends Equatable {
  final String? routineId;
  final String day;
  final String time;
  final String subject;
  final String type;
  final RoutineStatus status;

  const RoutineEntity({
    this.routineId,
    required this.day,
    required this.time,
    required this.subject,
    required this.type,
    this.status = RoutineStatus.active, 
  });

  @override
  List<Object?> get props => [routineId, day, time, subject, type, status];
}