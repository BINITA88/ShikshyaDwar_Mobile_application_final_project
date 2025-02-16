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

  Color _getStatusColor(RoutineStatus status) {
    switch (status) {
      case RoutineStatus.active:
        return Colors.green;
      case RoutineStatus.cancelled:
        return Colors.red;
      case RoutineStatus.paused:
        return Colors.amber;
      default:
        return Colors.grey;
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
                  color: _getStatusColor(routine.status),
                  child: ListTile(
                    title: Text(
                      routine.subject,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${routine.day}, ${routine.time}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                        Text(
                          routine.type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    trailing:
                        const Icon(Icons.calendar_today, color: Colors.white),
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
