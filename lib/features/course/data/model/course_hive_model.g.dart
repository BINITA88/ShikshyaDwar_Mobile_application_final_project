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
      coursePrice: fields[2] as num,
      instructor: fields[3] as String,
      courseImage: fields[4] as String?,
      duration: fields[5] as String,
      category: fields[6] as String?,
      courseDescription: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourseHiveModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.courseDescription);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseHiveModel _$CourseHiveModelFromJson(Map<String, dynamic> json) =>
    CourseHiveModel(
      courseId: json['courseId'] as String?,
      courseName: json['courseName'] as String,
      coursePrice: json['coursePrice'] as num,
      instructor: json['instructor'] as String,
      courseImage: json['courseImage'] as String?,
      duration: json['duration'] as String,
      category: json['category'] as String?,
      courseDescription: json['courseDescription'] as String,
    );

Map<String, dynamic> _$CourseHiveModelToJson(CourseHiveModel instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'coursePrice': instance.coursePrice,
      'instructor': instance.instructor,
      'courseImage': instance.courseImage,
      'duration': instance.duration,
      'category': instance.category,
      'courseDescription': instance.courseDescription,
    };
