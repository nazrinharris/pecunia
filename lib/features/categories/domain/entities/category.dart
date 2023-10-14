import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/shared/description.dart';
import 'package:uuid/uuid.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    // ========================= Seperation For Brevity =========================
    required String id,
    required String name,
    required Description description,
    // Hex Alpha Format (e.g. #FF0000FF)
    required String primaryColor,
    // ========================= Seperation For Brevity =========================
    IconData? icon,
    String? parentId,
  }) = _Category;

  const Category._();

  factory Category.newCategory({
    required Uuid uuid,
    required String name,
    required String primaryColor,
    String? description,
    IconData? icon,
    String? parentId,
  }) =>
      Category(
        id: uuid.v4(),
        parentId: parentId,
        name: name,
        description: Description(description),
        primaryColor: primaryColor,
        icon: icon,
      );

  factory Category.fromDTO(CategoryDTO dto) {
    return Category(
      id: dto.id,
      name: dto.name,
      description: Description(dto.description),
      primaryColor: dto.primaryColor,
      icon: dto.icon,
      parentId: dto.parentId,
    );
  }

  CategoryDTO toDTO() {
    return CategoryDTO(
      id: id,
      name: name,
      description: description.value,
      primaryColor: primaryColor,
      icon: icon,
      parentId: parentId,
    );
  }
}
