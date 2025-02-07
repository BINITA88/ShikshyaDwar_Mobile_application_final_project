import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/getAll_course_usecase.dart';


part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetAllCourseUsecase _getAllCourseUsecase;

  CourseBloc({required GetAllCourseUsecase getAllCourseUsecase})
      : _getAllCourseUsecase = getAllCourseUsecase,
        super(CourseState.initial()) {
    on<LoadCoursesEvent>(_onLoadCourses);
  }

  Future<void> _onLoadCourses(
      LoadCoursesEvent event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllCourseUsecase();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (courses) => emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        courses: courses, // Store fetched courses
      )),
    );
  }
}
