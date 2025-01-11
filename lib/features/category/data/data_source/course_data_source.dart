import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryDataSource {
  // Method to create a category
  Future<void> createCategory(CategoryEntity categoryEntity);

  // Method to update a category
  Future<void> updateCategory(CategoryEntity categoryEntity);

  // Method to retrieve all categories
  Future<List<CategoryEntity>> getAllCategories();

  // Method to delete a category by its ID
  Future<void> deleteCategory(String id);
}
