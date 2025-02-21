import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/widget/exam_seat_grid.dart';

class ExamSeatScreen extends StatelessWidget {
  const ExamSeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<ExamSeatBloc>();
        bloc.add(GetExamSeatsEvent()); // ✅ Ensure event is added once
        return bloc;
      },
      child: Scaffold(
        body: BlocBuilder<ExamSeatBloc, ExamSeatState>(
          builder: (context, state) {
            if (state is ExamSeatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExamSeatLoaded) {
              return ExamSeatGrid(seats: state.seats);
            } else if (state is ExamSeatError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
            return const Center(child: Text("No seats available."));
          },
        ),
      ),
    );
  }
}
