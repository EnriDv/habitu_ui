import 'package:flutter/material.dart';

class HabitEditorResult {
  final String title;
  final String? description;
  final String icon;
  final String colorHex;
  final List<int> daysOfWeek;
  final bool isPublic;
  final TimeOfDay reminderTime;

  const HabitEditorResult({
    required this.title,
    required this.description,
    required this.icon,
    required this.colorHex,
    required this.daysOfWeek,
    required this.isPublic,
    required this.reminderTime,
  });
}
