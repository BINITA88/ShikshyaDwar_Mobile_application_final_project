import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String categoryName;
 

  // category is remaining here as per your comment

  const CategoryEntity({
    this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
       
      ];
}
