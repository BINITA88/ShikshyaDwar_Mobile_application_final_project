
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

class ExamSeatModel extends ExamSeatEntity {
  const ExamSeatModel({
    required String examSeatId,
    required int seatNumber,
    required bool booked,
  }) : super(examSeatId: examSeatId, seatNumber: seatNumber, booked: booked);

  factory ExamSeatModel.fromJson(Map<String, dynamic> json) {
    return ExamSeatModel(
      examSeatId: json['_id'],
      seatNumber: json['seatNumber'],
      booked: json['booked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': examSeatId,
      'seatNumber': seatNumber,
      'booked': booked,
    };
  }
}
