import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/entity/category_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/repository/category_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/domain/use_case/getAll_category_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';

class MockCategoryRepository extends Mock implements ICategoryRepository {}

void main() {
  late MockCategoryRepository mockCategoryRepository;
  late GetAllCategoryUsecase getAllCategoryUsecase;

  final List<CategoryEntity> categoryList = [
    const CategoryEntity(categoryId: "1", categoryName: "IELTS"),
    const CategoryEntity(categoryId: "2", categoryName: "PTE"),
  ];

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    getAllCategoryUsecase = GetAllCategoryUsecase(mockCategoryRepository);
  });

  test('Should return List<CategoryEntity> when repository call is successful',
      () async {
    // Arrange
    when(() => mockCategoryRepository.getAllCategories())
        .thenAnswer((_) async => Right(categoryList));

    // Act
    final result = await getAllCategoryUsecase();

    // Assert
    expect(result, Right(categoryList));
    verify(() => mockCategoryRepository.getAllCategories()).called(1);
  });

  test('Should return a Failure when repository call fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Server error');
    when(() => mockCategoryRepository.getAllCategories())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await getAllCategoryUsecase();

    // Assert
    expect(result, Left(failure));
    verify(() => mockCategoryRepository.getAllCategories()).called(1);
  });
}
