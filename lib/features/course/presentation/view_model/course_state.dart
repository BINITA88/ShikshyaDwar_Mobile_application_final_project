part of 'course_bloc.dart';

class CourseState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<CourseEntity> courses; // Store fetched courses

  const CourseState({
    required this.isLoading,
    required this.isSuccess,
    required this.courses,
  });

  factory CourseState.initial() {
    return const CourseState(
      isLoading: false,
      isSuccess: false,
      courses: [],
    );
  }

  CourseState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<CourseEntity>? courses,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      courses: courses ?? this.courses,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, courses];
}
