import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/repository/category_repository.dart';

class GetAllCategoryUsecase
    implements UsecaseWithoutParams<List<CategoryEntity>> {
  final ICategoryRepository categoryRepository;

  GetAllCategoryUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoryRepository.getAllCategories();
  }
}
