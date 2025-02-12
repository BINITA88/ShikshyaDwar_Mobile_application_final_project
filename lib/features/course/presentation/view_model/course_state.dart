// import 'package:equatable/equatable.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

// class CourseState extends Equatable {
//   final bool isLoading;
//   final List<CourseEntity> courses;
//   final String? error;
//   final CourseEntity? selectedCourse;

//   const CourseState({
//     required this.isLoading,
//     required this.courses,
//     this.error,
//     this.selectedCourse,
//   });

//   factory CourseState.initial() {
//     return CourseState(
//       isLoading: false,
//       courses: [],
//       error: null,
//       selectedCourse: null,
//     );
//   }

//   CourseState copyWith({
//     bool? isLoading,
//     List<CourseEntity>? courses,
//     String? error,
//     CourseEntity? selectedCourse,
//   }) {
//     return CourseState(
//       isLoading: isLoading ?? this.isLoading,
//       courses: courses ?? this.courses,
//       error: error ?? this.error,
//       selectedCourse: selectedCourse ?? this.selectedCourse,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, courses, error, selectedCourse];
// }
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class CourseState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CourseEntity> courses;
  final CourseEntity? selectedCourse; // Add this to hold a single course

  const CourseState({
    required this.isLoading,
    required this.error,
    required this.courses,
    this.selectedCourse,
  });

  factory CourseState.initial() {
    return const CourseState(
      isLoading: false,
      error: null,
      courses: [],
      selectedCourse: null,
    );
  }

  CourseState copyWith({
    bool? isLoading,
    String? error,
    List<CourseEntity>? courses,
    CourseEntity? selectedCourse,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      courses: courses ?? this.courses,
      selectedCourse: selectedCourse ?? this.selectedCourse,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, courses, selectedCourse];
}
