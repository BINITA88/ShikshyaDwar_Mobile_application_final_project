import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/repository/category_repository.dart';

class DeleteCategoryParams {
  final String categoryId;
  const DeleteCategoryParams({required this.categoryId});

  const DeleteCategoryParams.empty() : categoryId = '_empty.string';
}

class DeleteCategoryUsecase
    implements UsecaseWithParams<void, DeleteCategoryParams> {
  final ICategoryRepository categoryRepository;

  DeleteCategoryUsecase({required this.categoryRepository});

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParams params) {
    return categoryRepository.deleteCategory(params.categoryId);
  }
}
