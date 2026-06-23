import 'package:flutter/material.dart';

class RankingCardViewModel {
  final int rank;
  final String fullName;
  final String habitTitle;
  final int currentStreak;
  final int longestStreak;
  final String? avatarUrl;
  final Color accentColor;
  final String initials;

  const RankingCardViewModel({
    required this.rank,
    required this.fullName,
    required this.habitTitle,
    required this.currentStreak,
    required this.longestStreak,
    required this.avatarUrl,
    required this.accentColor,
    required this.initials,
  });
}
