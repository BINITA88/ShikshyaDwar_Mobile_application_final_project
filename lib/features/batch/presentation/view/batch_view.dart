import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/presentation/view_model/batch_bloc.dart';


class BatchView extends StatelessWidget {
  BatchView({super.key});

  final batchNameController = TextEditingController();
  final _batchViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatchBloc, BatchState>(
      builder: (context, state) {
        return SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _batchViewFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Batch Name Input
                  TextFormField(
                    controller: batchNameController,
                    decoration: const InputDecoration(
                      labelText: 'Batch Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter batch name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // Add Batch Button
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null // Disable button while loading
                        : () {
                            if (_batchViewFormKey.currentState!.validate()) {
                              BlocProvider.of<BatchBloc>(context).add(
                                AddBatch(batchNameController.text.trim()),
                              );
                              batchNameController
                                  .clear(); // Clear the input after submission
                            }
                          },
                    child: state.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Add Batch'),
                  ),
                  const SizedBox(height: 20),
                  // Display List of Batches
                  if (state.batches.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.batches.length,
                        itemBuilder: (context, index) {
                          final batch = state.batches[index];
                          return ListTile(
                            title: Text(batch.batchName),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<BatchBloc>(context)
                                    .add(DeleteBatch(batch.batchId!));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state.error != null)
                    Center(
                      child: Text(
                        state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
