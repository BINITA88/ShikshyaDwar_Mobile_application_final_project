import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/repository/category_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateCategoryParams extends Equatable {
  final String categoryId; // ID is required for updating
  final String categoryName; // Correctly named for category

  const UpdateCategoryParams({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [categoryId, categoryName];
}

class UpdateCategoryUsecase {
  final ICategoryRepository categoryRepository;

  UpdateCategoryUsecase({required this.categoryRepository});

  Future<Either<Failure, void>> call(UpdateCategoryParams params) async {
    return await categoryRepository.updateCategory(CategoryEntity(
      categoryId: params.categoryId,
      categoryName: params.categoryName,
    ));
  }
}
