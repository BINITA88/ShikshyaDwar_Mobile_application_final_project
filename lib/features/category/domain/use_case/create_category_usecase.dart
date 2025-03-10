import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/repository/category_repository.dart';

class CreateCategoryParams extends Equatable {
  final String message;

  const CreateCategoryParams({
    required this.message,
  });

  const CreateCategoryParams.empty() : message = '_empty.string';

  @override
  List<Object?> get props => [message];
}

class CreateCategoryUsecase implements UsecaseWithParams<void, CreateCategoryParams> {
  final ICategoryRepository categoryRepository;

  CreateCategoryUsecase({required this.categoryRepository});

  @override
  Future<Either<Failure, void>> call(CreateCategoryParams params) async {
    return await categoryRepository.createCategory(CategoryEntity(
      message: params.message,
    ));
  }
}
