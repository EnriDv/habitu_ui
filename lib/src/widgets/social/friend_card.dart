import 'package:flutter/material.dart';

import '../../models/friend_card_view_model.dart';
import '../../tokens/habitu_colors.dart';

class FriendCard extends StatelessWidget {
  final FriendCardViewModel friend;
  final String actionLabel;
  final VoidCallback onPressed;

  const FriendCard({
    super.key,
    required this.friend,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: HabituColors.primary.withOpacity(0.15),
            backgroundImage: friend.avatarUrl != null ? NetworkImage(friend.avatarUrl!) : null,
            child: friend.avatarUrl == null
                ? Text(
                    friend.initials,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: HabituColors.primary,
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
                  friend.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HabituColors.onSurface,
                    fontFamily: 'Inter',
                    fontSize: 14,
                  ),
                ),
                if ((friend.subtitle ?? '').isNotEmpty)
                  Text(
                    friend.subtitle!,
                    style: const TextStyle(
                      color: HabituColors.onSurfaceVariant,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              actionLabel,
              style: const TextStyle(
                color: HabituColors.primary,
                fontFamily: 'Inter',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
