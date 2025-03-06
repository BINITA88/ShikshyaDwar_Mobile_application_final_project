import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial(0));

  // ✅ **Prevent selecting an invalid tab index**
  void onTabTapped(int index) {
    if (index >= 0 && index < state.views.length) {
      emit(state.copyWith(selectedIndex: index));
    }
  }

  // ✅ **Prevent invalid carousel index selection**
  void updateCarouselIndex(int index) {
    if (index >= 0 && index < state.carouselImages.length) {
      emit(state.copyWith(currentCarouselIndex: index));
    }
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeState.initial());

//   // ✅ **Prevent selecting an invalid tab index**
//   void onTabTapped(int index) {
//     if (index >= 0 && index < state.views.length) {
//       emit(state.copyWith(selectedIndex: index));
//     }
//   }

//   // ✅ **Prevent invalid carousel index selection**
//   void updateCarouselIndex(int index) {
//     if (index >= 0 && index < state.carouselImages.length) {
//       emit(state.copyWith(currentCarouselIndex: index));
//     }
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit(int userRole) : super(HomeState.initial(userRole));

//   // ✅ **Prevent selecting an invalid tab index**
//   void onTabTapped(int index) {
//     if (index >= 0 && index < state.views.length) {
//       emit(state.copyWith(selectedIndex: index));
//     }
//   }

//   // ✅ **Prevent invalid carousel index selection**
//   void updateCarouselIndex(int index) {
//     if (index >= 0 && index < state.carouselImages.length) {
//       emit(state.copyWith(currentCarouselIndex: index));
//     }
//   }
// }
