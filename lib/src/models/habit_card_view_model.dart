import 'package:flutter/material.dart';

class HabitCardViewModel {
  final String title;
  final String? description;
  final String frequencyLabel;
  final bool isPublic;
  final String completeLabel;
  final Color accentColor;
  final IconData icon;

  const HabitCardViewModel({
    required this.title,
    this.description,
    required this.frequencyLabel,
    required this.isPublic,
    this.completeLabel = 'Marcar completado',
    required this.accentColor,
    required this.icon,
  });
}
