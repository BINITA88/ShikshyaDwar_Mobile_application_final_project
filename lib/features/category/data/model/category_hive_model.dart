import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/constants/hive_table_constant.dart';

part 'category_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.categoryTableId)
class CategoryHiveModel extends Equatable {
  @HiveField(0)
  final String? categoryId;

  @HiveField(1)
  final String categoryName;

  CategoryHiveModel({
    String? categoryId,
    required this.categoryName,
  }) : categoryId = categoryId ?? const Uuid().v4();

  // Initial Constructor
  const CategoryHiveModel.initial()
      : categoryId = '',
        categoryName = '';

  // From Entity
  factory CategoryHiveModel.fromEntity(CategoryEntity entity) {
    return CategoryHiveModel(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
    );
  }

  // To Entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }

  // From entity list to model list
  static List<CategoryHiveModel> fromEntityList(List<CategoryEntity> entities) {
    return entities.map((e) => CategoryHiveModel.fromEntity(e)).toList();
  }

  // To entity list
  static List<CategoryEntity> toEntityList(List<CategoryHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [categoryId, categoryName];
}