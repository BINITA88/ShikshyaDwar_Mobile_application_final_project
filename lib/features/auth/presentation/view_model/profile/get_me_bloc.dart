// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_me_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/profile/get_me_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/profile/get_me_state.dart';

// class GetMeBloc extends Bloc<GetMeEvent, GetMeState> {
//   final GetCurrentUserUseCase getMeUseCase;

//   GetMeBloc(this.getMeUseCase) : super(GetMeInitial()) {
//     on<FetchUserEvent>(_onFetchUser);
//   }

//   Future<void> _onFetchUser(
//       FetchUserEvent event, Emitter<GetMeState> emit) async {
//     emit(GetMeLoading());

//     final Either<Failure, AuthEntity> result = await getMeUseCase(authId);

//     result.fold(
//       (failure) => emit(GetMeError(failure)),
//       (user) => emit(GetMeLoaded(user)),
//     );
//   }
// }



