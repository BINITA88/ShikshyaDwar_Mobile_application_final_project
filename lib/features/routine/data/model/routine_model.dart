import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';

class RoutineModel extends RoutineEntity {
  RoutineModel({
    required String day,
    required String time,
    required String subject,
    required String type,
    required RoutineStatus status,
    String? routineId,
  }) : super(
          routineId: routineId,
          day: day,
          time: time,
          subject: subject,
          type: type,
          status: status,
        );

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      routineId: json['routineId'],
      day: json['day'],
      time: json['time'],
      subject: json['subject'],
      type: json['type'],
      status: RoutineStatus.values.firstWhere(
          (e) => e.toString() == 'RoutineStatus.${json['status']}',
          orElse: () => RoutineStatus.active),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
      'day': day,
      'time': time,
      'subject': subject,
      'type': type,
      'status': status.toString().split('.').last,
    };
  }
}
