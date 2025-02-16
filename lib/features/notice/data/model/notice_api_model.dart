import '../../domain/entity/notice_entity.dart';

class NoticeModel extends NoticeEntity {
  const NoticeModel({
    required String super.noticeId,
    required super.message,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeId: json['id'].toString(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': noticeId,
      'message': message,
    };
  }
}
