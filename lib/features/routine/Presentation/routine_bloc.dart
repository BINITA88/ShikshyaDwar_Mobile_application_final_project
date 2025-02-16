import 'package:bloc/bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/use%20_case/get_all_routine._usecase.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final GetAllRoutinesUseCase _allRoutinesUseCase;

  RoutineBloc({required GetAllRoutinesUseCase allRoutinesUseCase})
      : _allRoutinesUseCase = allRoutinesUseCase,
        super(RoutineState.initial()) {
    on<LoadRoutinesEvent>(_onLoadRoutines);
  }

  Future<void> _onLoadRoutines(
      LoadRoutinesEvent event, Emitter<RoutineState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _allRoutinesUseCase();

    result.fold(
      (failure) => emit(
          state.copyWith(isLoading: false, isSuccess: false, error: failure)),
      (routines) => emit(state.copyWith(
          isLoading: false, isSuccess: true, routines: routines)),
    );
  }
}
