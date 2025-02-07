import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NoticeEntity extends Equatable {
  final String? noticeId;
  final String message;
 


  const NoticeEntity({
    this.noticeId,
    required this.message,
  });

  @override
  List<Object?> get props => [
        noticeId,
        message,
       
      ];
}
