import 'package:flutter/material.dart';

import '../../models/challenge_card_view_model.dart';
import '../../tokens/habitu_colors.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeCardViewModel challenge;
  final bool isJoining;
  final VoidCallback? onJoin;

  const ChallengeCard({
    super.key,
    required this.challenge,
    this.isJoining = false,
    this.onJoin,
  });

  Color get _categoryColor {
    switch (challenge.category.toLowerCase()) {
      case 'salud':
        return const Color(0xFF96D3BD);
      case 'estudio':
        return const Color(0xFFA7C8FF);
      case 'deporte':
        return const Color(0xFFE2B2B2);
      default:
        return const Color(0xFFD0B2E2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _categoryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: challenge.isJoined
            ? Border.all(color: const Color(0xFF96D3BD).withOpacity(0.4), width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        challenge.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                          letterSpacing: 1,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (challenge.isJoined)
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF96D3BD), size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Unido',
                            style: TextStyle(
                              color: Color(0xFF96D3BD),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  challenge.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HabituColors.onSurface,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                if ((challenge.description ?? '').isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    challenge.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: HabituColors.onSurfaceVariant,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: HabituColors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      challenge.dateRangeLabel,
                      style: const TextStyle(
                        color: HabituColors.onSurfaceVariant,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.group_outlined, size: 14, color: HabituColors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      challenge.participantsLabel,
                      style: const TextStyle(
                        color: HabituColors.onSurfaceVariant,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                if (!challenge.isJoined) ...[
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isJoining || challenge.isFull ? null : onJoin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: isJoining
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black54),
                            )
                          : Text(
                              challenge.isFull ? 'Reto lleno' : 'Unirme al reto',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                            ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
