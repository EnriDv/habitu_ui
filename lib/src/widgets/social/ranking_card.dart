import 'package:flutter/material.dart';

import '../../models/ranking_card_view_model.dart';
import '../../tokens/habitu_colors.dart';

class RankingCard extends StatelessWidget {
  final RankingCardViewModel entry;

  const RankingCard({super.key, required this.entry});

  Color get _medalColor {
    switch (entry.rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return HabituColors.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTop3 = entry.rank <= 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isTop3 ? _medalColor.withOpacity(0.08) : HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: isTop3
            ? Border.all(color: _medalColor.withOpacity(0.3), width: 1)
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: isTop3
                ? Text(
                    entry.rank == 1 ? '🥇' : entry.rank == 2 ? '🥈' : '🥉',
                    style: const TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    '${entry.rank}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HabituColors.onSurfaceVariant,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundColor: entry.accentColor.withOpacity(0.15),
            backgroundImage: entry.avatarUrl != null ? NetworkImage(entry.avatarUrl!) : null,
            child: entry.avatarUrl == null
                ? Text(
                    entry.initials,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: entry.accentColor,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HabituColors.onSurface,
                    fontFamily: 'Inter',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: entry.accentColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        entry.habitTitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: HabituColors.onSurfaceVariant,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 2),
                  Text(
                    '${entry.currentStreak}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isTop3 ? _medalColor : entry.accentColor,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Text(
                'mejor: ${entry.longestStreak}',
                style: const TextStyle(
                  fontSize: 10,
                  color: HabituColors.onSurfaceVariant,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
