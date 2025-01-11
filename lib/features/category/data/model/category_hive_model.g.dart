// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_hive_model.dart';

class CategoryHiveModelAdapter extends TypeAdapter<CategoryHiveModel> {
  @override
  final int typeId = 3; // Assign a unique ID for Category

  @override
  CategoryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryHiveModel(
      categoryId: fields[0] as String?,
      categoryName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryHiveModel obj) {
    writer
      ..writeByte(2) // Total number of fields
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.categoryName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
