import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CourseEntity extends Equatable {
  final String? courseId;
  final String courseName;
  final num coursePrice;
  final String instructor;
  final String? courseImage;
  final String duration;
  final String courseDescription;
  final String? category;

  // category is remaining here as per your comment

  const CourseEntity(
      {required this.coursePrice,
      required this.instructor,
      this.courseImage,
      required this.duration,
      this.courseId,
      required this.courseName,
      this.category,
      required this.courseDescription});

  const CourseEntity.empty()
      : courseId = '_empty.courseId',
        courseName = '_empty.courseName',
        coursePrice = 0,
        instructor = '_empty.instructor',
        courseImage = null,
        duration = '_empty.duration',
        courseDescription = '_empty.courseDescription',
        category = null;

  @override
  List<Object?> get props => [
        courseId,
        courseName,
        coursePrice,
        instructor,
        courseImage,
        duration,
        courseDescription,
        category
      ];
}
