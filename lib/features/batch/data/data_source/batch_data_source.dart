

import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchDataSource {
  Future<void> createBatch(BatchEntity batchEntity);

  Future<List<BatchEntity>> getAllBatches();

  Future<void> deleteBatch(String id);

// searchByID ene hru thapyo vane sab ma milaune jate ota xa tate ota rakhne
}
