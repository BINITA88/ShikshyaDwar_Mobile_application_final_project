import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/view_models/notice_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/presentation/view/notice_card.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart'; // ✅ Import GetIt DI

class NoticeViewPage extends StatelessWidget {
  const NoticeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            getIt<NoticeBloc>()..add(LoadNoticeEvent()), // ✅ Uses GetIt for DI
        child: BlocBuilder<NoticeBloc, NoticeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isSuccess && state.notices.isNotEmpty) {
              return ListView.builder(
                itemCount: state.notices.length,
                itemBuilder: (context, index) {
                  return NoticeCard(notice: state.notices[index]);
                },
              );
            } else if (state.isSuccess && state.notices.isEmpty) {
              return const Center(child: Text('No notices available.'));
            } else {
              return const Center(child: Text('Failed to load notices.'));
            }
          },
        ),
      ),
    );
  }
}
