import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, void>> createCategory(CategoryEntity categoryEntity);
  Future<Either<Failure, void>> updateCategory(CategoryEntity categoryEntity);
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, void>> deleteCategory(String id);
}
