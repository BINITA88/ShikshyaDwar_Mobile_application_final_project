// import 'package:equatable/equatable.dart';
// import 'package:shikshyadwar_mobile_application_project/features/notice/domain/entity/notice_entity.dart';



// class NoticeState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final List<NoticeEntity> notices; // ✅ Changed `message` to `notices` for clarity
//   final String? errorMessage; // ✅ Added for error handling

//   const NoticeState({
//     required this.isLoading,
//     required this.isSuccess,
//     required this.notices,
//     this.errorMessage,
//   });

//   // ✅ Initial state when app starts
//   factory NoticeState.initial() {
//     return const NoticeState(
//       isLoading: false,
//       isSuccess: false,
//       notices: [],
//       errorMessage: null,
//     );
//   }

//   // ✅ CopyWith for immutable state updates
//   NoticeState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     List<NoticeEntity>? notices,
//     String? errorMessage,
//   }) {
//     return NoticeState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       notices: notices ?? this.notices,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess, notices, errorMessage];
// }
