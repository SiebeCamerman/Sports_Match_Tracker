import 'package:sports_match_tracker/services/choice_chip_data.dart';
import 'package:flutter/material.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'Basketball',
      isSelected: false,
      selectedColor: Color(0xffffc107),
      textColor: Colors.black,
      iconColor: "FFAA33"
    ),
    ChoiceChipData(
      label: 'Tennis',
      isSelected: false,
      selectedColor: Color(0xffffc107),
      textColor: Colors.black,
      iconColor: "FDDA0D"
    ),
    ChoiceChipData(
      label: 'Soccer',
      isSelected: false,
      selectedColor: Color(0xffffc107),
      textColor: Colors.black,
      iconColor: "52c72e"
    ),
    ChoiceChipData(
      label: 'Padel',
      isSelected: false,
      selectedColor: Color(0xffffc107),
      textColor: Colors.black,
      iconColor: "0000FF"
    ),
  ];
}