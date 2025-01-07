import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';

import 'package:uuid/uuid.dart';

// part garni adapter ko lagi

// it is a adapter class for generating automatically
part 'batch_hive_model.g.dart';
// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel extends Equatable {
  @HiveField(0)
  final String? batchId;
  @HiveField(1)
  final String batchName;

  BatchHiveModel({
    String? batchId,
    required this.batchName,
  }) : batchId = batchId ?? const Uuid().v4();

  //Initail Constructor
  const BatchHiveModel.initial()
      : batchId = '',
        batchName = '';

  //from entity
  factory BatchHiveModel.fromEntity(BatchEntity entity) {
    return BatchHiveModel(
      batchId: entity.batchId,
      batchName: entity.batchName,
    );
  }

  // to entity
  BatchEntity toEntity() {
    return BatchEntity(
      batchId: batchId,
      batchName: batchName,
    );
  }

  // from entity list
  static List<BatchHiveModel> fromEntityList(List<BatchEntity> entityList) {
    return entityList
        .map((entity) => BatchHiveModel.fromEntity(entity))
        .toList();
  }

  // to entity list
  static List<BatchEntity> toEntityList(List<BatchHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [batchId, batchName];
}
