// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseHiveModelAdapter extends TypeAdapter<CourseHiveModel> {
  @override
  final int typeId = 2;

  @override
  CourseHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseHiveModel(
      courseId: fields[0] as String?,
      courseName: fields[1] as String,
      coursePrice: fields[2] as double,
      instructor: fields[3] as String,
      courseImage: fields[4] as String,
      duration: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourseHiveModel obj) {
    writer
      ..writeByte(6) // Total number of fields
      ..writeByte(0)
      ..write(obj.courseId)
      ..writeByte(1)
      ..write(obj.courseName)
      ..writeByte(2)
      ..write(obj.coursePrice)
      ..writeByte(3)
      ..write(obj.instructor)
      ..writeByte(4)
      ..write(obj.courseImage)
      ..writeByte(5)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
