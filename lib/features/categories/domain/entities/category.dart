import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:uuid/uuid.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    // ========================= Seperation For Brevity =========================
    required String id,
    required String name,
    required CategoryDescription description,
    required String primaryColor,
    // ========================= Seperation For Brevity =========================
    Icon? icon,
    String? parentId,
  }) = _Category;

  const Category._();

  factory Category.newCategory({
    required Uuid uuid,
    required String name,
    required String primaryColor,
    String? description,
    String? icon,
    String? parentId,
  }) =>
      Category(
        id: uuid.v4(),
        parentId: parentId,
        name: name,
        description: CategoryDescription(description),
        primaryColor: primaryColor,
        icon: icon != null ? const Icon(Icons.warning) : null,
      );

  factory Category.fromDTO(CategoryDTO dto) {
    return Category(
      id: dto.id,
      name: dto.name,
      description: CategoryDescription(dto.description),
      primaryColor: dto.primaryColor,
      icon: dto.icon != null ? const Icon(Icons.warning) : null,
      parentId: dto.parentId,
    );
  }

  CategoryDTO toDTO() {
    return CategoryDTO(
      id: id,
      name: name,
      description: description.value,
      primaryColor: primaryColor,
      icon: icon?.icon.toString(),
      parentId: parentId,
    );
  }
}

/// Value object for the description of a transaction
/// The description can be null, so check for that.
@immutable
class CategoryDescription {
  CategoryDescription(String? input) : value = _validateInput(input);

  final String? value;

  @override
  String toString() => value ?? 'No Description';

  static String? _validateInput(String? input) {
    if (input == null || input.trim().isEmpty) {
      return null;
    }
    return input;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryDescription && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
