import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/core/Fingerprint/fingerprint_auth.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/internet_checker/internet_checker.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/api_service.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';
import 'package:shikshyadwar_mobile_application_project/core/socket_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/remote_datasource/otp_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/auth_remote_repository.dart/auth_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/otp_remote_repository.dart/otp_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/forgot_password_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_all_users_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_verify_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/logout_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/reset-password_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/verify/verify_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/data/data_source/remote_data_source/booking_remote_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/data/repository/booking_remote_repository/booking_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/data/data_source/remote_data_source/chat_remote_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/data/repository/chat_remote_repository/chat_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/usecase/delete_message_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/usecase/get_message_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/domain/usecase/send_message_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view_model/bloc/chat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/repository/course_repository_impl.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/repository/course_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_course_details_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/data/data_source/remote_datasource/exam_seat_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/data/repository/remote_repository/exam_seat_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/book_seat.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/get_all_seat.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/unbook_seat.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/Presentation/view_models/notice_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/data/remote_data_source/notice_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/data/repository/notice_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/repository/notice_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/notice/domain/use%20_case/get_all_notice_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/data/data_source/remote_datasource/payment_remte_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/data/repository/payment_repository_impl.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/repository/payment_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/use_cases/get_stripe_api_key_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/use_cases/proccess_payment_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/Presentation/routine_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/data/data_source/remote_datasource/routine_remote_datasource_impl.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/data/repository/routine_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/repository/routine_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/use%20_case/get_all_routine._usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/onboarding_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';

//  it is a service locator
final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // _initSocketService(); // ✅ Register WebSocketManager FIRST
  // _initSetupLocator(); // ✅ Register chat-related dependencies
  await _initHiveService();
  await _initApiService();
  _initNetworkInfo(); // ✅ Register NetworkInfo first
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initCourseBookingDependencies();
  await _initNoticeDependencies();
  _initRoutineDependencies();
  initExamSeatDependencies();
  _initChatDependencies();
  await _initPaymentDependencies();
  await _initVerifyDependencies();
  await _initSharedPreferences();
  _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
  _initCourseDependencies();
  await _initAuthDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

void _initNetworkInfo() {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<InternetConnectionChecker>(() =>
      InternetConnectionChecker.createInstance()); // ✅ Use createInstance()

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      getIt<Connectivity>(),
      getIt<InternetConnectionChecker>(),
    ),
  );
}

// _initRegisterDependencies() {
//   // init local data source
//   getIt.registerLazySingleton(
//     () => AuthLocalDataSource(getIt<HiveService>()),
//   );

//   // init local repository
//   getIt.registerLazySingleton(
//     () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
//   );

//   // register use usecase
//   getIt.registerLazySingleton<RegisterUseCase>(
//     () => RegisterUseCase(
//       getIt<AuthLocalRepository>(),
//     ),
//   );

//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(
//       registerUseCase: getIt(),
//     ),
//   );
// }

// _initLoginDependencies() async {
//   // Use common StudentLocalDatasource and StudentLocalRepository
//   getIt.registerLazySingleton<LoginStudentUsecase>(() =>
//       LoginStudentUsecase(studentRepository: getIt<StudentLocalRepository>()));
//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(),
//       homeCubit: getIt<HomeCubit>(),
//       batchBloc: getIt<BatchBloc>(),
//       courseBloc: getIt<CourseBloc>(),
//       loginStudentUsecase: getIt<LoginStudentUsecase>(),
//     ),
//   );
// }

/// ==================== web socket Register ===================

// void _initSocketService() {
//   if (!GetIt.I.isRegistered<WebSocketManager>()) {
//     getIt.registerLazySingleton<WebSocketManager>(() => WebSocketManager());
//   }
// }

// ---------------------------- Chat Dependencies ----------------------------

// void _initSetupLocator() {
//   getIt.registerLazySingleton<ChatRemoteDataSource>(
//     () => ChatRemoteDataSourceImpl(dio: getIt<Dio>()),
//   );

//   getIt.registerLazySingleton<ChatRepository>(
//     () => ChatRepositoryImpl(remoteDataSource: getIt<ChatRemoteDataSource>()),
//   );

//   getIt.registerLazySingleton<GetMessages>(
//     () => GetMessages(getIt<ChatRepository>()),
//   );

//   getIt.registerLazySingleton<SendMessage>(
//     () => SendMessage(getIt<ChatRepository>()),
//   );
// }

// .............................................register.......................

_initRegisterDependencies() {
  //DataSource

  // getIt.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSource(getIt<HiveService>()),
  // );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>(), getIt<TokenSharedPrefs>()),
  );

  //Repository

  // getIt.registerLazySingleton(
  //   () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  // );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );

  //UseCase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
      file: null,
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
      createStudentUsecase: getIt(),
      verifyBloc: getIt(),
    ),
  );
}

// ...............................chatting.......................................

_initChatDependencies() {
  if (!getIt.isRegistered<ChatRemoteDataSource>()) {
    getIt.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSource(getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<ChatRemoteRepository>()) {
    getIt.registerLazySingleton<ChatRemoteRepository>(
      () => ChatRemoteRepository(
        getIt<ChatRemoteDataSource>(),
      ),
    );
  }

  if (!getIt.isRegistered<SendMessageUseCase>()) {
    getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(
        chatRepository: getIt<ChatRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );
  }

  if (!getIt.isRegistered<GetMessagesUseCase>()) {
    getIt.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(
        chatRepository: getIt<ChatRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );
  }

  if (!getIt.isRegistered<DeleteMessageUseCase>()) {
    getIt.registerLazySingleton<DeleteMessageUseCase>(
      () => DeleteMessageUseCase(
        chatRepository: getIt<ChatRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ),
    );

    if (!getIt.isRegistered<ChatBloc>()) {
      getIt.registerFactory<ChatBloc>(
        () => ChatBloc(
          sendMessageUseCase: getIt<SendMessageUseCase>(),
          // getMessageUseCase: getIt<GetMessagesUseCase>(), // Corrected here
          // deleteMessageUseCase: getIt<DeleteMessageUseCase>(),
          getMessagesUseCase: getIt<GetMessagesUseCase>(),
          deletemessageUseCase: getIt(),
          // tokenSharedPrefs: getIt<TokenSharedPrefs>(),
        ),
      );
    }
  }
}

// ...............................booking.......................................
_initCourseBookingDependencies() {
  //DataSource

  // getIt.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSource(getIt<HiveService>()),
  // );

  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSource(getIt<Dio>()),
  );

//Repository

  // getIt.registerLazySingleton(
  //   () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  // );

  getIt.registerLazySingleton<BookingRemoteRepository>(
    () => BookingRemoteRepository(getIt<BookingRemoteDataSource>()),
  );

//UseCase
  getIt.registerLazySingleton<CreateBookingUsecase>(
    () => CreateBookingUsecase(
      getIt<BookingRemoteRepository>(),
    ),
  );

  getIt.registerFactory<BookingBloc>(
    () => BookingBloc(
      createBookingUsecase: getIt(),
      paymentBloc: getIt(),
    ),
  );
}

// ...............................payment.......................................

_initPaymentDependencies() {
  // ✅ Register Remote Data Source
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // ✅ Register Repository
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(remoteDataSource: getIt()),
  );

  // ✅ Register Use Cases
  getIt.registerLazySingleton(
    () => ProcessPaymentUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetStripeApiKeyUseCase(repository: getIt()),
  );

  // ✅ Register Bloc
  getIt.registerFactory(
    () => PaymentBloc(
      processPaymentUseCase: getIt(),
      // getStripeApiKeyUseCase: getIt(),
    ),
  );
}
// ..........................notice...........................

_initNoticeDependencies() {
  getIt.registerLazySingleton<NoticeRemoteDataSource>(
    () => NoticeRemoteDataSource(getIt<Dio>()),
  );

  // ✅ Register Remote Data Source
  getIt.registerLazySingleton<INoticeRemoteDataSource>(
    () => NoticeRemoteDataSource(getIt()),
  );

  // ✅ Register Repository Interface
  getIt.registerLazySingleton<INoticeRepository>(
    () => NoticeRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<NoticeRepositoryImpl>(
    () =>
        NoticeRepositoryImpl(remoteDataSource: getIt<NoticeRemoteDataSource>()),
  );

  // ✅ Register Use Cases
  getIt.registerLazySingleton(
    () => GetAllNoticesUseCase(
      noticeRepository: getIt(),
    ),
  );
  getIt.registerFactory<NoticeBloc>(
    () => NoticeBloc(
      getAllNoticesUseCase: getIt(),
    ),
  );
}

// .........................................routine....................
void _initRoutineDependencies() {
  // ✅ Ensure Dio is registered first
  getIt.registerLazySingleton<RoutineRemoteDataSource>(
    () => RoutineRemoteDataSourceImpl(getIt()),
  );

  // ✅ Register Routine Repository
  if (!getIt.isRegistered<RoutineRepository>()) {
    getIt.registerLazySingleton<RoutineRepository>(
      () => RoutineRepositoryImpl(
        routineRemoteDataSource: getIt(),
      ),
    );
  }

  // ✅ Register Use Case
  if (!getIt.isRegistered<GetAllRoutinesUseCase>()) {
    getIt.registerLazySingleton<GetAllRoutinesUseCase>(
      () => GetAllRoutinesUseCase(
        routineRepository: getIt<RoutineRepository>(),
      ),
    );
  }

  // ✅ Register RoutineBloc
  if (!getIt.isRegistered<RoutineBloc>()) {
    getIt.registerFactory<RoutineBloc>(
      () => RoutineBloc(allRoutinesUseCase: getIt<GetAllRoutinesUseCase>()),
    );
  }
}

// ..............................mock test booking..........................................
void initExamSeatDependencies() {
  getIt.registerLazySingleton<IExamSeatRemoteDataSource>(
    () => ExamSeatRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<IExamSeatRepository>(
    () => ExamSeatRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton(() => GetAllSeat(getIt<IExamSeatRepository>()));
  getIt.registerLazySingleton(() => BookSeat(getIt<IExamSeatRepository>()));
  getIt.registerLazySingleton(() => UnbookSeat(getIt<IExamSeatRepository>()));

  getIt.registerFactory(
    () => ExamSeatBloc(
        getAllSeat: getIt<GetAllSeat>(),
        bookSeat: getIt<BookSeat>(),
        unbookSeat: getIt<UnbookSeat>()),
  );
}

// // ....................r..................
// void _initRoutineDependencies() {
//   // ✅ Register Remote Data Source
//   getIt.registerLazySingleton<IRoutineRemoteDataSource>(
//     () => RoutineRemoteDataSource(getIt<Dio>()),
//   );

//   // ✅ Register Repository Properly as an Interface
//   getIt.registerLazySingleton<RoutineRepository>(
//     () => RoutineRepositoryImpl(getIt<IRoutineRemoteDataSource>(),
//         routineRemoteDataSource: getIt()),
//   );

//   // ✅ Register Use Case (Ensuring Proper Dependency Order)
//   getIt.registerLazySingleton<GetAllRoutinesUseCase>(
//     () => GetAllRoutinesUseCase(routineRepository: getIt()),
//   );

//   // ✅ Register BLoC
//   getIt.registerFactory<RoutineBloc>(
//     () => RoutineBloc(allRoutinesUseCase: getIt()),
//   );
// }

/// ====================  Verify email ===================
// _initVerifyDependencies() {
//   //DataSource

//   //UseCase
//   getIt.registerLazySingleton<GetVerifyUsecase>(
//     () => GetVerifyUsecase(
//       getIt<OtpRemoteRepository>(),
//     ),
//   );
// }

_initVerifyDependencies() {
  //DataSource

  getIt.registerLazySingleton<OtpRemoteDatasource>(
    () => OtpRemoteDatasource(getIt<Dio>()),
  );

  //Repository

  getIt.registerLazySingleton<OtpRemoteRepository>(
    () => OtpRemoteRepository(getIt<OtpRemoteDatasource>()),
  );

  //UseCase
  getIt.registerLazySingleton<GetVerifyUsecase>(
    () => GetVerifyUsecase(
      getIt<OtpRemoteRepository>(),
    ),
  );

  getIt.registerFactory<VerifyBloc>(
    () => VerifyBloc(
      verifyusecase: getIt(),
    ),
  );
}

// /// ====================  Login ===================
// _initLoginDependencies() async {
//   //Token Shared Preferences
//   getIt.registerLazySingleton<TokenSharedPrefs>(
//     () => TokenSharedPrefs(getIt<SharedPreferences>()),
//   );

//   //UseCase
// // Use common StudentLocalDatasource and StudentLocalRepository

//   getIt.registerLazySingleton<LoginUseCase>(() =>
//       LoginUseCase(getIt<TokenSharedPrefs>(), getIt<AuthRemoteRepository>()));

//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(),
//       homeCubit: getIt<HomeCubit>(),
//       // courseBloc: getIt<CourseBloc>(),
//       loginUseCase: getIt<LoginUseCase>(),
//       getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
//     ),
//   );
// }

// _initLoginDependencies() async {
//   // ✅ Ensure AuthRemoteRepository is registered first
//   if (!getIt.isRegistered<AuthRemoteRepository>()) {
//     getIt.registerLazySingleton<AuthRemoteRepository>(
//       () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
//     );
//   }

//   // ✅ Register Token Shared Preferences
//   getIt.registerLazySingleton<TokenSharedPrefs>(
//     () => TokenSharedPrefs(getIt<SharedPreferences>()),
//   );

//   // ✅ Register Use Cases
//   getIt.registerLazySingleton<LoginUseCase>(
//     () =>
//         LoginUseCase(getIt<TokenSharedPrefs>(), getIt<AuthRemoteRepository>()),
//   );

//   getIt.registerLazySingleton<GetCurrentUserUseCase>(
//     () => GetCurrentUserUseCase(getIt<AuthRemoteRepository>()),
//   );

//   // ✅ Register LoginBloc (AFTER RegisterBloc & HomeCubit are available)
//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(), // Ensure it's registered
//       homeCubit: getIt<HomeCubit>(), // Ensure it's registered
//       loginUseCase: getIt<LoginUseCase>(),
//       getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
//       tokenSharedPrefs: getIt<TokenSharedPrefs>(),
//       forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
//       resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
//     ),
//   );
// }
void _initLoginDependencies() async {
  // ✅ Ensure AuthRemoteRepository is registered first
  if (!getIt.isRegistered<AuthRemoteRepository>()) {
    getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
    );
  }

  // ✅ Register Token Shared Preferences
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // ✅ Register Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () =>
        LoginUseCase(getIt<TokenSharedPrefs>(), getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRemoteRepository>()),
  );

  // ✅ Register Missing ForgotPasswordUseCase & ResetPasswordUseCase
  if (!getIt.isRegistered<ForgotPasswordUseCase>()) {
    getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt<AuthRemoteRepository>()),
    );
  }

  if (!getIt.isRegistered<ResetPasswordUseCase>()) {
    getIt.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt<AuthRemoteRepository>()),
    );
  }

  // ✅ Ensure RegisterBloc & HomeCubit are registered before LoginBloc
  if (!getIt.isRegistered<RegisterBloc>()) {
    getIt.registerLazySingleton<RegisterBloc>(() => RegisterBloc(
        verifyBloc: getIt(),
        registerUseCase: getIt(),
        uploadImageUsecase: getIt(),
        createStudentUsecase: getIt()));
  }

  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
  }

  // ✅ Register LoginBloc AFTER everything else is registered
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      // registerBloc: getIt<RegisterBloc>(), // ✅ Ensure it's registered
      // homeCubit: getIt<HomeCubit>(), // ✅ Ensure it's registered
      loginUseCase: getIt<LoginUseCase>(),
      // getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      forgotPasswordUseCase:
          getIt<ForgotPasswordUseCase>(), // ✅ Fixed missing dependency
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
      fingerprintAuth: getIt<FingerprintAuth>(), // ✅ Fixed missing dependency
    ),
  );
}

// // ..........................course...............
// _initCourseDependencies() {
//   // =========================== Data Source ===========================

//   getIt.registerFactory<CourseLocalDataSource>(() => CourseLocalDataSource(
//       hiveService: getIt<HiveService>(), networkInfo: getIt()));

//   getIt.registerFactory<CourseRemoteDataSource>(
//       () => CourseRemoteDataSource(getIt<Dio>()));

//   // =========================== Repository ===========================

//   getIt
//       .registerLazySingleton<CourseLocalRepository>(() => CourseLocalRepository(
//             courseLocalDataSource: getIt<CourseLocalDataSource>(),
//             courseRemoteDataSource: getIt(),
//             networkInfo: getIt(),
//           ));

//   getIt.registerLazySingleton<CourseRemoteRepository>(
//     () => CourseRemoteRepository(
//       getIt<CourseRemoteDataSource>(),
//     ),
//   );

//   // Usecases

//   getIt.registerLazySingleton<GetAllCourseUsecase>(
//     () => GetAllCourseUsecase(
//       courseRepository: getIt<CourseRemoteRepository>(),
//     ),
//   );

//   getIt.registerLazySingleton<GetCourseDetailUseCase>(
//     () => GetCourseDetailUseCase(
//       courseRepository: getIt<CourseRemoteRepository>(),
//     ),
//   );

// // Bloc
//   getIt.registerFactory<CourseBloc>(
//     () => CourseBloc(
//       getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
//       getCourseDetailUsecase: getIt<GetCourseDetailUseCase>(),
//       bookingBloc: getIt(), // Fixed: Removed duplicate parameter
//     ),
//   );
// }

// ..........................course...............
void _initCourseDependencies() {
  // ✅ Ensure Dio is registered before using it
  if (!getIt.isRegistered<Dio>()) {}

  // ✅ Ensure NetworkInfo is registered before using it
  if (!getIt.isRegistered<NetworkInfo>()) {
    getIt.registerLazySingleton<Connectivity>(() => Connectivity());
    getIt.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker.createInstance());

    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        getIt<Connectivity>(),
        getIt<InternetConnectionChecker>(),
      ),
    );
  }

  // ✅ Register Hive Service Before Local Data Source
  if (!getIt.isRegistered<HiveService>()) {
    getIt.registerLazySingleton<HiveService>(() => HiveService());
  }

  // ✅ Register CourseLocalDataSource
  if (!getIt.isRegistered<CourseLocalDataSource>()) {
    getIt.registerLazySingleton<CourseLocalDataSource>(
      () => CourseLocalDataSource(
        hiveService: getIt<HiveService>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    );
  }

  // ✅ Register CourseRemoteDataSource
  if (!getIt.isRegistered<CourseRemoteDataSource>()) {
    getIt.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSource(getIt<Dio>()),
    );
  }

  // ✅ Register Repository
  if (!getIt.isRegistered<ICourseRepository>()) {
    getIt.registerLazySingleton<ICourseRepository>(
      () => CourseRepositoryImpl(
        courseLocalDataSource: getIt<CourseLocalDataSource>(),
        courseRemoteDataSource: getIt<CourseRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    );
  }

  // ✅ Register Use Cases
  if (!getIt.isRegistered<GetAllCourseUsecase>()) {
    getIt.registerLazySingleton<GetAllCourseUsecase>(
      () => GetAllCourseUsecase(courseRepository: getIt<ICourseRepository>()),
    );
  }

  if (!getIt.isRegistered<GetCourseDetailUseCase>()) {
    getIt.registerLazySingleton<GetCourseDetailUseCase>(
      () =>
          GetCourseDetailUseCase(courseRepository: getIt<ICourseRepository>()),
    );
  }

  // ✅ Register Bloc
  if (!getIt.isRegistered<CourseBloc>()) {
    getIt.registerFactory<CourseBloc>(
      () => CourseBloc(
        getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
        getCourseDetailUsecase: getIt<GetCourseDetailUseCase>(),
        bookingBloc: getIt(),
      ),
    );
  }

  print("✅ _initCourseDependencies Completed");
}

// ......................................
_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}

// Future<void> _initAuthDependencies() async {
//   if (!getIt.isRegistered<TokenSharedPrefs>()) {
//     getIt.registerLazySingleton<TokenSharedPrefs>(
//       () => TokenSharedPrefs(getIt<SharedPreferences>()),
//     );
//   }

//   // if (!getIt.isRegistered<LoginUseCase>()) {
//   //   getIt.registerLazySingleton<LoginUseCase>(
//   //     () => LoginUseCase(
//   //         getIt<AuthRemoteRepository>(), getIt<TokenSharedPrefs>()),
//   //   );
//   // }

//   if (!getIt.isRegistered<LogoutUseCase>()) {
//     getIt.registerLazySingleton<LogoutUseCase>(
//       () => LogoutUseCase(getIt<TokenSharedPrefs>()),
//     );
//   }

//   if (!getIt.isRegistered<GetAllUsersUseCase>()) {
//     getIt.registerLazySingleton<GetAllUsersUseCase>(
//       () => GetAllUsersUseCase(getIt<AuthRemoteRepository>()),
//     );
//   }

//   if (!getIt.isRegistered<AuthBloc>()) {
//     getIt.registerFactory<AuthBloc>(
//       () => AuthBloc(
//         loginUseCase: getIt<LoginUseCase>(),
//         logoutUseCase: getIt<LogoutUseCase>(),
//         tokenPrefs: getIt<TokenSharedPrefs>(),
//         getAllUsersUseCase: getIt<GetAllUsersUseCase>(),
//         fingerprintAuth: getIt(), // ✅ Corrected
//       ),
//     );
//   }
// }
Future<void> _initAuthDependencies() async {
  if (!getIt.isRegistered<FingerprintAuth>()) {
    // ✅ Ensure this comes first
    getIt.registerLazySingleton<FingerprintAuth>(
      () => FingerprintAuth(),
    );
  }

  if (!getIt.isRegistered<TokenSharedPrefs>()) {
    getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()),
    );
  }

  if (!getIt.isRegistered<LogoutUseCase>()) {
    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(getIt<TokenSharedPrefs>()),
    );
  }

  if (!getIt.isRegistered<GetAllUsersUseCase>()) {
    getIt.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(getIt<AuthRemoteRepository>()),
    );
  }

  // ✅ Register UpdateUserProfileUseCase
  if (!getIt.isRegistered<GetAllUsersUseCase>()) {
    getIt.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(getIt<AuthRemoteRepository>()),
    );
  }

  if (!getIt.isRegistered<AuthBloc>()) {
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: getIt<LoginUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        tokenPrefs: getIt<TokenSharedPrefs>(),
        getAllUsersUseCase: getIt<GetAllUsersUseCase>(),
        fingerprintAuth: getIt<FingerprintAuth>(), // ✅ Now correctly registered
      ),
    );
  }
}

















// hive  try


// void _initCourseDependencies() async {
//   // ✅ Register Hive Box for Courses
//   final courseBox = await Hive.openBox<CourseHiveModel>('coursesBox');
//   getIt.registerLazySingleton<Box<CourseHiveModel>>(() => courseBox);

//   // ======================== Data Source =========================

//   getIt.registerFactory<CourseLocalDataSource>(
//     () => CourseLocalDataSource(
//       hiveService: getIt<HiveService>(),
//       networkInfo: getIt<NetworkInfo>(),
//       box: getIt<Box<CourseHiveModel>>(), // ✅ Use the registered box
//     ),
//   );

//   getIt.registerFactory<CourseRemoteDataSource>(
//     () => CourseRemoteDataSource(getIt<Dio>()),
//   );

//   // ======================== Repository =========================

//   getIt.registerLazySingleton<CourseRepositoryImpl>(
//     () => CourseRepositoryImpl(
//       // courseLocalDataSource: getIt<CourseLocalDataSource>(),
//       // courseRemoteDataSource: getIt<CourseRemoteDataSource>(),
//       networkInfo: getIt<NetworkInfo>(),
//       localDataSource: getIt<CourseLocalDataSource>(),
//       remoteDataSource: getIt<CourseRemoteDataSource>(),
//     ),
//   );

//   getIt.registerLazySingleton<CourseRemoteRepository>(
//     () => CourseRemoteRepository(getIt<CourseRemoteDataSource>()),
//   );
// }
