// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_all_course_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

// part 'course_event.dart';

// class CourseBloc extends Bloc<CourseEvent, CourseState> {
//   final GetAllCourseUsecase _getAllCourseUsecase;

//   CourseBloc({
//     required GetAllCourseUsecase getAllCourseUsecase,
//   })  : _getAllCourseUsecase = getAllCourseUsecase,
//         super(CourseState.initial()) {
//     on<CourseLoad>(_onCourseLoad);

//     // Start fetching courses automatically
//     add(CourseLoad());
//   }

//   Future<void> _onCourseLoad(
//     CourseLoad event,
//     Emitter<CourseState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, error: null)); // Reset errors before loading

//     final result = await _getAllCourseUsecase();

//     result.fold(
//       (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
//       (courses) => emit(state.copyWith(isLoading: false, courses: courses)),
//     );
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_course_details_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_state.dart';

part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetAllCourseUsecase _getAllCourseUsecase;
  final GetCourseDetailUseCase _getCourseDetailUsecase; // Add use case for course details
  final BookingBloc _bookingBloc;

  CourseBloc({
    required BookingBloc bookingBloc,

    required GetAllCourseUsecase getAllCourseUsecase,
    required GetCourseDetailUseCase getCourseDetailUsecase, // Inject the new use case
  })  :_bookingBloc = bookingBloc,
   _getAllCourseUsecase = getAllCourseUsecase,
        _getCourseDetailUsecase = getCourseDetailUsecase,
        super(CourseState.initial()) {
    on<CourseLoad>(_onCourseLoad);
    on<CourseDetailLoad>(_onCourseDetailLoad);
     // Handle course details fetching
   on<NavigateBookingScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value:_bookingBloc ),
            ],
            child: event.destination,
          ),
        ),
      );
    });
    // Start fetching courses automatically
    add(CourseLoad());
  }

  Future<void> _onCourseLoad(
    CourseLoad event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null)); // Reset errors before loading

    final result = await _getAllCourseUsecase();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) => emit(state.copyWith(isLoading: false, courses: courses)),
    );
  }

  Future<void> _onCourseDetailLoad(
    CourseDetailLoad event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null)); // Reset loading state

    final result = await _getCourseDetailUsecase(event.courseId);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (course) => emit(state.copyWith(isLoading: false, selectedCourse: course)),
    );
  }
}
