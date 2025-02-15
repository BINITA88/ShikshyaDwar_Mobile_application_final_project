// part of 'course_bloc.dart';


// sealed class CourseEvent extends Equatable {
//   const CourseEvent();

//   @override
//   List<Object> get props => [];
// }

// class CourseLoad extends CourseEvent {}


 
//   @override
//   List<Object> get props => [];

part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}


class NavigateBookingScreenEvent extends CourseEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateBookingScreenEvent({
    required this.context,
    required this.destination,
  });
}


class CourseLoad extends CourseEvent {} // Existing event

class CourseDetailLoad extends CourseEvent { // New event
  final String courseId;

  const CourseDetailLoad(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
