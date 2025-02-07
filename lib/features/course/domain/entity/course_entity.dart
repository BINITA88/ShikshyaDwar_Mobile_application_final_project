import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CourseEntity extends Equatable {
  final String? courseId;
  final String courseName;
  final double coursePrice;
  final String instructor;
  final String courseImage;
  final String duration;
  final String courseDescription;
  final Object category;

  // category is remaining here as per your comment

  const CourseEntity(
      {required this.coursePrice,
      required this.instructor,
      required this.courseImage,
      required this.duration,
      this.courseId,
      required this.courseName,
      required this.category,
      required this.courseDescription});

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
