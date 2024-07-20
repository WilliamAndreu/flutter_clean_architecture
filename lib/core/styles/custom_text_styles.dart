import 'package:flutter/material.dart';
import 'package:rickmorty/core/utils/navigator_util.dart';

class CustomTextStyles {
  static final CustomTextStyles _instance = CustomTextStyles._internal();

  factory CustomTextStyles() {
    return _instance;
  }

  CustomTextStyles._internal();

  // * Default
  // Size 26
  TextStyle get default26w700 => TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Theme.of(Navify().currentContext!).colorScheme.onSurfaceVariant,
      );

  // Size 16
  TextStyle get default16w700 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Theme.of(Navify().currentContext!).colorScheme.onSurfaceVariant,
      );

  TextStyle get default16w500 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(Navify().currentContext!).colorScheme.onSurfaceVariant,
      );

  // Size 14
  TextStyle get default14w500 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Theme.of(Navify().currentContext!).colorScheme.onSurfaceVariant,
      );
}
