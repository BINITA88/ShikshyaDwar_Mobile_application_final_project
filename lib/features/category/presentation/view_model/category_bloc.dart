import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/use_case/getAll_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoryUsecase getAllCategoryUsecase;

  CategoryBloc(this.getAllCategoryUsecase) : super(CategoryInitial()) {
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());

      final result = await getAllCategoryUsecase();

      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (categories) => emit(CategoryLoaded(categories)),
      );
    });
  }
}
