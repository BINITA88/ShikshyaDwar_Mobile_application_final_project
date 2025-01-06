import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
          selectedIndex: 3,
          carouselImages: [
            'assets/images/cr1.png',
            'assets/images/cr2.png',
            'assets/images/cr3.png',
          ],
          products: [
            {
              "image": "assets/images/reading.png",
              "title": "IELTS Class",
              "date": "10 Dec 2024",
              "duration": "2 Months",
            },
            {
              "image": "assets/images/pte.png",
              "title": "PTE Class",
              "date": "11 Dec 2024",
              "duration": "2 Months",
            },
            {
              "image": "assets/images/reading.png",
              "title": "SAT Class",
              "date": "12 Dec 2024",
              "duration": "2 Months",
            },
            {
              "image": "assets/images/pte.png",
              "title": "TOEFL Class",
              "date": "13 Dec 2024",
              "duration": "2 Months",
            },
          ],
          views: HomeState.initial().views, // Use the initial views
        ));

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void updateCarouselIndex(int index) {
    emit(state.copyWith(currentCarouselIndex: index));
  }
}
