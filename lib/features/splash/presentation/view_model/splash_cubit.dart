import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view/onboarding_page.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/onboarding_cubit.dart';

class SplashCubit extends Cubit<int> {
  SplashCubit(this._onboardingCubit) : super(0); // Initialize with 0

  final OnboardingCubit _onboardingCubit;

  void updatePage(int index) {
    emit(index); // Properly updates page index
  }

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _onboardingCubit,
            child: const OnboardingPage(),
          ),
        ),
      );
    }
  }
}
