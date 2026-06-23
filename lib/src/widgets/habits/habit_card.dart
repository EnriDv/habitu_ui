import 'package:flutter/material.dart';

import '../../models/habit_card_view_model.dart';
import '../core/habitu_card.dart';

class HabitCard extends StatefulWidget {
  final HabitCardViewModel habit;
  final VoidCallback? onComplete;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const HabitCard({
    super.key,
    required this.habit,
    this.onComplete,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  Offset? _tapDownPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _tapDownPosition = details.globalPosition,
      onTap: widget.onTap,
      onLongPress: () => _showContextMenu(context),
      child: HabituCard(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: widget.habit.accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.habit.icon,
                    color: widget.habit.accentColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.habit.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if ((widget.habit.description ?? '').isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            widget.habit.description!,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      widget.onEdit?.call();
                    } else if (value == 'delete') {
                      widget.onDelete?.call();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar')),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Chip(
                    avatar: const Icon(Icons.repeat, size: 18),
                    label: Text(widget.habit.frequencyLabel),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.habit.isPublic)
                  const Expanded(
                    child: Chip(
                      avatar: Icon(Icons.public, size: 18),
                      label: Text('Público'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: widget.onComplete,
                icon: const Icon(Icons.check),
                label: Text(widget.habit.completeLabel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.habit.accentColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    final position = _tapDownPosition;
    if (position == null) {
      return;
    }

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: const [
        PopupMenuItem(value: 'edit', child: Text('Editar')),
        PopupMenuItem(value: 'delete', child: Text('Eliminar')),
      ],
    ).then((value) {
      if (value == 'edit') {
        widget.onEdit?.call();
      } else if (value == 'delete') {
        widget.onDelete?.call();
      }
    });
  }
}
