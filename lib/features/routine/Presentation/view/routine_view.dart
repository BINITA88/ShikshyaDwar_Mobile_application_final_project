import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<RoutineBloc>();
        bloc.add(LoadRoutinesEvent()); // ✅ Ensure event is only added once
        return bloc;
      },
      child: Scaffold(
        body: BlocBuilder<RoutineBloc, RoutineState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.isSuccess && state.routines.isNotEmpty) {
              return RoutineTable(routines: state.routines);
            }
            if (state.isSuccess && state.routines.isEmpty) {
              return const Center(
                child: Text(
                  'No routines available.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return const Center(
              child: Text(
                'Failed to load routines',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RoutineTable extends StatelessWidget {
  final List<RoutineEntity> routines;

  const RoutineTable({Key? key, required this.routines}) : super(key: key);

  /// ✅ **Applies fixed color for index 2 & 5 (Red) and index 4 (Yellow), else dynamic**
  Color _getStatusColor(int index, RoutineStatus status) {
    if (index == 2 || index == 5)
      return Colors.red.shade100; // ✅ Force 3rd & 6th as Red
    if (index == 4) return Colors.yellow.shade100; // ✅ Force 5th as Yellow

    switch (status) {
      case RoutineStatus.active:
        return Colors.green.shade100; // ✅ Light green for active
      case RoutineStatus.cancelled:
        return Colors.red.shade100; // ✅ Light red for cancelled
      case RoutineStatus.paused:
        return Colors.yellow.shade100; // ✅ Light yellow for paused
      default:
        return Colors.grey.shade200;
    }
  }

  /// ✅ **Adjust text colors to match background for readability**
  Color _getTextColor(int index, RoutineStatus status) {
    if (index == 2 || index == 5)
      return Colors.red.shade800; // ✅ Ensure dark red text
    if (index == 4) return Colors.orange.shade800; // ✅ Ensure dark yellow text

    switch (status) {
      case RoutineStatus.active:
        return Colors.green.shade800;
      case RoutineStatus.cancelled:
        return Colors.red.shade800;
      case RoutineStatus.paused:
        return Colors.orange.shade800;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Weekly Routine',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, index) {
                final routine = routines[index];
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: _getStatusColor(index, routine.status),
                  child: ListTile(
                    title: Text(
                      routine.subject,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _getTextColor(index, routine.status),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${routine.day}, ${routine.time}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getTextColor(index, routine.status)),
                        ),
                        Text(
                          routine.type,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: _getTextColor(index, routine.status),
                          ),
                        ),
                      ],
                    ),
                    trailing:
                        const Icon(Icons.calendar_today, color: Colors.black54),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
