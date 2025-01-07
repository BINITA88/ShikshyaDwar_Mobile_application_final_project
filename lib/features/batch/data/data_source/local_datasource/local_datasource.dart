
import 'package:shikshyadwar_mobile_application_project/features/batch/data/data_source/batch_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/data/model/batch_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';

class LocalDataSource implements IBatchDataSource {
  final HiveService _hiveService;

  LocalDataSource(this._hiveService);

  @override
  Future<void> createBatch(BatchEntity batchEntity) async {
    try {
      // convert batchenetity to batchModel
      final batchHiveModel = BatchHiveModel.fromEntity(batchEntity);
      await _hiveService.addBatch((batchHiveModel));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBatch(String id) async {
    try {
      // convert batchenetity to batchModel
      return await _hiveService.deleteBatch((id));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BatchEntity>> getAllBatches() {
    try {
      // convert batch entity to batchModel
      // toentity garni kina bhane   unique id 1 2 garera list ma auos ahnera entity ma  
      return _hiveService.getAllBatches().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
