import 'package:flutter/material.dart';

import 'habit_detail_log_view_model.dart';

class HabitDetailViewModel {
  final String title;
  final int currentStreak;
  final int longestStreak;
  final List<HabitDetailLogViewModel> logs;
  final Color accentColor;

  const HabitDetailViewModel({
    required this.title,
    required this.currentStreak,
    required this.longestStreak,
    required this.logs,
    required this.accentColor,
  });
}
