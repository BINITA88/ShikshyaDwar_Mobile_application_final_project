import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:uuid/uuid.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  BatchBloc() : super(BatchState.initial()) {
    on<LoadBatches>(_onLoadBatches);
    on<AddBatch>(_onAddBatch);
    on<DeleteBatch>(_onDeleteBatch);
  }

  Future<void> _onLoadBatches(
      LoadBatches event, Emitter<BatchState> emit) async {}

  Future<void> _onAddBatch(AddBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final newBatch = BatchEntity(
        batchId: const Uuid().v4(),
        batchName: event.batchName,
      );
      final updatedBatches = List<BatchEntity>.from(state.batches)
        ..add(newBatch);
      emit(state.copyWith(batches: updatedBatches, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to add batch.'));
    }
  }

  Future<void> _onDeleteBatch(
      DeleteBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final updatedBatches = state.batches
          .where((batch) => batch.batchId != event.batchId)
          .toList();
      emit(state.copyWith(batches: updatedBatches, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to delete the batch. Please try again.',
      ));
    }
  }
}
