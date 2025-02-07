import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/use_case/getAll_category_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/presentation/view_model/category_bloc.dart';

// Mock classes
class MockGetAllCategoryUsecase extends Mock implements GetAllCategoryUsecase {}

void main() {
  late MockGetAllCategoryUsecase mockGetAllCategoryUsecase;
  late CategoryBloc categoryBloc;

  final List<CategoryEntity> categoryList = [
    const CategoryEntity(categoryId: "1", categoryName: "IELTS"),
    const CategoryEntity(categoryId: "2", categoryName: "PTE"),
  ];

  setUp(() {
    mockGetAllCategoryUsecase = MockGetAllCategoryUsecase();
    categoryBloc = CategoryBloc(mockGetAllCategoryUsecase);
  });

  test('Initial state should be CategoryInitial', () {
    expect(categoryBloc.state, CategoryInitial());
  });

  blocTest<CategoryBloc, CategoryState>(
    'Emits [CategoryLoading, CategoryLoaded] when GetAllCategoriesEvent is added and succeeds',
    build: () {
      when(() => mockGetAllCategoryUsecase())
          .thenAnswer((_) async => Right(categoryList));
      return categoryBloc;
    },
    act: (bloc) => bloc.add(GetAllCategoriesEvent()),
    expect: () => [
      CategoryLoading(),
      CategoryLoaded(categoryList),
    ],
    verify: (_) {
      verify(() => mockGetAllCategoryUsecase()).called(1);
    },
  );

  blocTest<CategoryBloc, CategoryState>(
    'Emits [CategoryLoading, CategoryError] when GetAllCategoriesEvent fails',
    build: () {
      when(() => mockGetAllCategoryUsecase())
          .thenAnswer((_) async => Left(ApiFailure(message: "Server error")));
      return categoryBloc;
    },
    act: (bloc) => bloc.add(GetAllCategoriesEvent()),
    expect: () => [
      CategoryLoading(),
      const CategoryError("Server error"),
    ],
    verify: (_) {
      verify(() => mockGetAllCategoryUsecase()).called(1);
    },
  );
}
