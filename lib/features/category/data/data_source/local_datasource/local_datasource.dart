// import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
// import 'package:shikshyadwar_mobile_application_project/features/category/data/data_source/course_data_source.dart';
// import 'package:shikshyadwar_mobile_application_project/features/category/data/model/category_hive_model.dart';
// import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';

// abstract class LocalCategoryDatasource implements ICategoryDataSource {
//   final HiveService _hiveService;

//   LocalCategoryDatasource(this._hiveService);

//   @override
//   Future<void> createCategory(CategoryEntity categoryEntity) async {
//     try {
//       // Convert categoryEntity to CategoryHiveModel
//       final categoryHiveModel = CategoryHiveModel.fromEntity(categoryEntity);
//       await _hiveService.addCategory(categoryHiveModel);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<void> deleteCategory(String id) async {
//     try {
//       // Delete category using categoryId
//       return await _hiveService.deleteCategory(id);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<List<CategoryEntity>> getAllCategories() async {
//     try {
//       // Retrieve all categories and convert them to CategoryEntity
//       return _hiveService.getAllCategories().then((value) {
//         return value.map((e) => e.toEntity()).toList();
//       });
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<void> updateCategory(CategoryEntity categoryEntity) async {
//     try {
//       // Convert categoryEntity to CategoryHiveModel
//       final categoryHiveModel = CategoryHiveModel.fromEntity(categoryEntity);
//       await _hiveService.updateCategory(
//           categoryHiveModel); // Call updateCategory in HiveService
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
