import 'package:equatable/equatable.dart';

class BatchEntity extends Equatable {
  final String? batchId;
  final String batchName;

  const BatchEntity({
    this.batchId,
    required this.batchName,
  });

  /// Static constant for an empty BatchEntity
  static const BatchEntity empty = BatchEntity(
    batchId: null,
    batchName: '_empty.batch',
  );

  @override
  List<Object?> get props => [batchId, batchName];
}
