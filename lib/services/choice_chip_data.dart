import 'package:flutter/material.dart';

class ChoiceChipData {
  final String label;
  final bool isSelected;
  Color textColor;
  Color selectedColor;
  String iconColor;

  ChoiceChipData({
    required this.label,
    required this.isSelected,
    required this.textColor,
    required this.selectedColor,
    required this.iconColor,
  });

  ChoiceChipData copy({
    String? label,
    bool? isSelected,
    Color? textColor,
    Color? selectedColor,
    String? iconColor,
  }) =>
      ChoiceChipData(
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,
        textColor: textColor ?? this.textColor,
        selectedColor: selectedColor ?? this.selectedColor,
        iconColor: iconColor ?? this.iconColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ChoiceChipData &&
              runtimeType == other.runtimeType &&
              label == other.label &&
              isSelected == other.isSelected &&
              textColor == other.textColor &&
              selectedColor == other.selectedColor &&
              iconColor == other.iconColor;

  @override
  int get hashCode =>
      label.hashCode ^
      isSelected.hashCode ^
      textColor.hashCode ^
      selectedColor.hashCode^
      iconColor.hashCode;
}