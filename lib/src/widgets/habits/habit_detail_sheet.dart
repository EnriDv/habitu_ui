import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/habit_detail_log_view_model.dart';
import '../../models/habit_detail_view_model.dart';
import '../../tokens/habitu_colors.dart';
import '../foundations/empty_state_card.dart';
import '../foundations/info_pill.dart';
import '../foundations/stat_card.dart';

class HabitDetailSheet extends StatefulWidget {
  final HabitDetailViewModel habit;
  final VoidCallback onEdit;
  final Future<bool> Function()? onDelete;

  const HabitDetailSheet({
    super.key,
    required this.habit,
    required this.onEdit,
    this.onDelete,
  });

  @override
  State<HabitDetailSheet> createState() => _HabitDetailSheetState();
}

class _HabitDetailSheetState extends State<HabitDetailSheet> {
  DateTime? _selectedDate;
  bool _isDeleting = false;

  int _daysInMonth(DateTime date) {
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  HabitDetailLogViewModel? _selectedLog(List<HabitDetailLogViewModel> logs) {
    if (logs.isEmpty) {
      return null;
    }

    if (_selectedDate != null) {
      for (final log in logs) {
        final completedAt = DateTime(
          log.completedAt.year,
          log.completedAt.month,
          log.completedAt.day,
        );
        if (completedAt == _selectedDate) {
          return log;
        }
      }
    }

    return logs.first;
  }

  Widget _buildEvidencePreview(HabitDetailLogViewModel log) {
    final evidencePath = log.evidencePath;
    if (evidencePath == null || evidencePath.isEmpty) {
      return const SizedBox.shrink();
    }

    final uri = Uri.tryParse(evidencePath);
    final isRemote = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    final localFile = File(evidencePath);
    final hasLocalFile = !isRemote && localFile.existsSync();

    if (!isRemote && !hasLocalFile) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: HabituColors.surfaceContainer,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: const Text(
          'La evidencia quedó registrada, pero esta imagen ya no está disponible en este dispositivo.',
          textAlign: TextAlign.center,
          style: TextStyle(color: HabituColors.onSurfaceVariant),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: isRemote
            ? Image.network(
                evidencePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: HabituColors.surfaceContainer,
                  alignment: Alignment.center,
                  child: const Text('No pudimos cargar la evidencia.'),
                ),
              )
            : Image.file(localFile, fit: BoxFit.cover),
      ),
    );
  }

  Future<void> _handleDelete() async {
    if (widget.onDelete == null || _isDeleting) {
      return;
    }

    setState(() {
      _isDeleting = true;
    });

    final deleted = await widget.onDelete!();
    if (!mounted) {
      return;
    }

    setState(() {
      _isDeleting = false;
    });

    if (deleted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logs = List<HabitDetailLogViewModel>.from(widget.habit.logs)
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    final selectedLog = _selectedLog(logs);

    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final totalDays = _daysInMonth(now);
    final startOffset = firstDay.weekday - 1;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.habit.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: widget.onEdit,
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Racha activa',
                    value: '${widget.habit.currentStreak} días',
                    icon: Icons.local_fire_department_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'Racha máxima',
                    value: '${widget.habit.longestStreak} días',
                    icon: Icons.workspace_premium_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Consistencia este mes',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HabituColors.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.03)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['L', 'M', 'M', 'J', 'V', 'S', 'D'].map((label) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: HabituColors.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalDays + startOffset,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (index < startOffset) {
                        return const SizedBox.shrink();
                      }

                      final dayNum = index - startOffset + 1;
                      final dayDate = DateTime(now.year, now.month, dayNum);
                      HabitDetailLogViewModel? log;
                      for (final entry in logs) {
                        final entryDate = DateTime(
                          entry.completedAt.year,
                          entry.completedAt.month,
                          entry.completedAt.day,
                        );
                        if (entryDate == dayDate) {
                          log = entry;
                          break;
                        }
                      }
                      final isCompleted = log != null;
                      final isSelected = _selectedDate != null && dayDate == _selectedDate;

                      return InkWell(
                        borderRadius: BorderRadius.circular(99),
                        onTap: isCompleted
                            ? () {
                                setState(() {
                                  _selectedDate = dayDate;
                                });
                              }
                            : null,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? widget.habit.accentColor.withOpacity(0.18)
                                : isCompleted
                                    ? HabituColors.tertiary.withOpacity(0.2)
                                    : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? widget.habit.accentColor
                                  : isCompleted
                                      ? HabituColors.tertiary
                                      : Colors.white.withOpacity(0.05),
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            dayNum.toString(),
                            style: TextStyle(
                              color: isSelected
                                  ? widget.habit.accentColor
                                  : isCompleted
                                      ? HabituColors.tertiary
                                      : HabituColors.onSurface,
                              fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Detalle del registro',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (selectedLog == null)
              const EmptyStateCard(
                title: 'Todavía no hay registros',
                subtitle: 'Cuando completes este hábito, aquí podrás ver hora, nota y evidencia.',
              )
            else
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: HabituColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.03)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        InfoPill(
                          icon: Icons.calendar_today_outlined,
                          text:
                              '${selectedLog.completedAt.day}/${selectedLog.completedAt.month}/${selectedLog.completedAt.year}',
                        ),
                        InfoPill(
                          icon: Icons.schedule_outlined,
                          text:
                              '${selectedLog.completedAt.hour.toString().padLeft(2, '0')}:${selectedLog.completedAt.minute.toString().padLeft(2, '0')}',
                        ),
                        InfoPill(
                          icon: selectedLog.evidencePath == null
                              ? Icons.notes_outlined
                              : Icons.image_outlined,
                          text: selectedLog.evidencePath == null
                              ? 'Sin evidencia'
                              : 'Con evidencia',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if ((selectedLog.notes ?? '').isNotEmpty) ...[
                      Text(
                        'Nota',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.habit.accentColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedLog.notes!,
                        style: const TextStyle(color: HabituColors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (selectedLog.evidencePath != null &&
                        selectedLog.evidencePath!.isNotEmpty) ...[
                      Text(
                        'Evidencia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.habit.accentColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildEvidencePreview(selectedLog),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Historial reciente',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (logs.isEmpty)
              const EmptyStateCard(
                title: 'Sin historial todavía',
                subtitle: 'Tus últimas completadas aparecerán aquí.',
              )
            else
              ...logs.take(8).map(
                    (log) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: HabituColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          setState(() {
                            _selectedDate = DateTime(
                              log.completedAt.year,
                              log.completedAt.month,
                              log.completedAt.day,
                            );
                          });
                        },
                        leading: CircleAvatar(
                          backgroundColor: widget.habit.accentColor.withOpacity(0.12),
                          child: Icon(
                            log.evidencePath == null
                                ? Icons.check_circle_outline
                                : Icons.image_outlined,
                            color: widget.habit.accentColor,
                          ),
                        ),
                        title: Text(
                          '${log.completedAt.day}/${log.completedAt.month} · ${log.completedAt.hour.toString().padLeft(2, '0')}:${log.completedAt.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          (log.notes ?? '').isEmpty ? 'Sin nota' : log.notes!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
            if (widget.onDelete != null) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isDeleting ? null : _handleDelete,
                icon: _isDeleting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.delete_outline),
                label: const Text('Eliminar hábito'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HabituColors.errorContainer.withOpacity(0.2),
                  foregroundColor: HabituColors.error,
                  side: BorderSide(color: HabituColors.error.withOpacity(0.2)),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
