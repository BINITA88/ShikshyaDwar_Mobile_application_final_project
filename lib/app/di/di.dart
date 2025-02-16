import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/api_service.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/core/socket_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/data/data_source/chat_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/data/repository/chat_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/get_messages.dart';
import 'package:shikshyadwar_mobile_application_project/features/Message/domain/use_case/send_message.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/remote_datasource/otp_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/auth_remote_repository.dart/auth_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/repository/otp_remote_repository.dart/otp_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_verify_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/verify/verify_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/data/data_source/remote_data_source/booking_remote_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/data/repository/booking_remote_repository/booking_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/repository/course_local_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/repository/course_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_course_details_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
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

import '../../features/Message/domain/repository/chat_repository.dart';

//  it is a service locator
final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initSocketService(); // ✅ Register WebSocketManager FIRST
  _initSetupLocator(); // ✅ Register chat-related dependencies
  await _initHiveService();
  await _initApiService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initCourseBookingDependencies();
  await _initNoticeDependencies();
  _initRoutineDependencies();
  await _initPaymentDependencies();
  await _initVerifyDependencies();
  await _initSharedPreferences();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
  await _initCourseDependencies();
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

void _initSocketService() {
  if (!GetIt.I.isRegistered<WebSocketManager>()) {
    getIt.registerLazySingleton<WebSocketManager>(() => WebSocketManager());
  }
}

// ---------------------------- Chat Dependencies ----------------------------

void _initSetupLocator() {
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: getIt<ChatRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetMessages>(
    () => GetMessages(getIt<ChatRepository>()),
  );

  getIt.registerLazySingleton<SendMessage>(
    () => SendMessage(getIt<ChatRepository>()),
  );
}

// .............................................register.......................

_initRegisterDependencies() {
  //DataSource

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );

  //Repository

  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
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
      getStripeApiKeyUseCase: getIt(),
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
// .........................................
void _initRoutineDependencies() {
  // ✅ Ensure Dio is registered first
    getIt.registerLazySingleton<RoutineRemoteDataSource>(
    () => RoutineRemoteDataSourceImpl( getIt()),
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

/// ====================  Login ===================
_initLoginDependencies() async {
  //Token Shared Preferences
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  //UseCase
// Use common StudentLocalDatasource and StudentLocalRepository

  getIt.registerLazySingleton<LoginUseCase>(() =>
      LoginUseCase(getIt<TokenSharedPrefs>(), getIt<AuthRemoteRepository>()));

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      // courseBloc: getIt<CourseBloc>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// ..........................course...............
_initCourseDependencies() {
  // =========================== Data Source ===========================

  getIt.registerFactory<CourseLocalDataSource>(
      () => CourseLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerFactory<CourseRemoteDataSource>(
      () => CourseRemoteDataSource(getIt<Dio>()));

  // =========================== Repository ===========================

  getIt.registerLazySingleton<CourseLocalRepository>(() =>
      CourseLocalRepository(
          courseLocalDataSource: getIt<CourseLocalDataSource>()));

  getIt.registerLazySingleton<CourseRemoteRepository>(
    () => CourseRemoteRepository(
      getIt<CourseRemoteDataSource>(),
    ),
  );

  // Usecases

  getIt.registerLazySingleton<GetAllCourseUsecase>(
    () => GetAllCourseUsecase(
      courseRepository: getIt<CourseRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetCourseDetailUseCase>(
    () => GetCourseDetailUseCase(
      courseRepository: getIt<CourseRemoteRepository>(),
    ),
  );

// Bloc
  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
      getCourseDetailUsecase: getIt<GetCourseDetailUseCase>(),
      bookingBloc: getIt(), // Fixed: Removed duplicate parameter
    ),
  );
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
