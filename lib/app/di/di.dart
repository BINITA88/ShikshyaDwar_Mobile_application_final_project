import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/api_service.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
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
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/dto/get_all_course_dto.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/repository/course_local_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/repository/course_remote_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/use_case/get_course_details_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/onboarding_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';

//  it is a service locator
final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
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

/// ====================  Register ===================

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
      // homeCubit: getIt<HomeCubit>(),
      courseBloc: getIt<CourseBloc>(),
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
      getCourseDetailUsecase:
          getIt<GetCourseDetailUseCase>(), // Fixed: Removed duplicate parameter
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
