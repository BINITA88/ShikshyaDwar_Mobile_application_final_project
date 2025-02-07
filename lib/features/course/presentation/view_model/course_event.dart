// part of 'course_bloc.dart';


// sealed class CourseEvent extends Equatable {
//   const CourseEvent();

//   @override
//   List<Object> get props => [];
// }


// class BookingScreenEvent extends CourseEvent {
//   final BuildContext context;
//   final Widget destination;

//   const BookingScreenEvent({
//     required this.context,
//     required this.destination,
//   });
// }




part of 'course_bloc.dart';

sealed class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesEvent extends CourseEvent {}
