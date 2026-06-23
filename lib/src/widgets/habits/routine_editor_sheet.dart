import 'package:flutter/material.dart';

import '../../models/routine_editor_result.dart';
import '../../tokens/habitu_colors.dart';

class RoutineEditorSheet extends StatefulWidget {
  final String? routineId;
  final String? initialTitle;
  final String? initialDescription;
  final String initialTimeOfDay;
  final String? initialAnchorTime;
  final List<int> initialDaysOfWeek;
  final Future<void> Function(RoutineEditorResult result) onSubmit;

  const RoutineEditorSheet({
    super.key,
    this.routineId,
    this.initialTitle,
    this.initialDescription,
    this.initialTimeOfDay = 'morning',
    this.initialAnchorTime,
    this.initialDaysOfWeek = const [],
    required this.onSubmit,
  });

  @override
  State<RoutineEditorSheet> createState() => _RoutineEditorSheetState();
}

class _RoutineEditorSheetState extends State<RoutineEditorSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late String _timeOfDay;
  late List<int> _daysOfWeek;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descriptionController = TextEditingController(text: widget.initialDescription ?? '');
    _timeOfDay = widget.initialTimeOfDay;
    _daysOfWeek = List<int>.from(widget.initialDaysOfWeek);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        decoration: const BoxDecoration(
          color: HabituColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.routineId == null ? 'Nueva rutina' : 'Editar rutina',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                minLines: 2,
                maxLines: 3,
              ),
              const SizedBox(height: 18),
              const Text('Momento del día', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final option in const ['morning', 'afternoon', 'evening', 'custom'])
                    ChoiceChip(
                      label: Text(option),
                      selected: _timeOfDay == option,
                      onSelected: (_) {
                        setState(() {
                          _timeOfDay = option;
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 18),
              const Text('Días', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(7, (index) {
                  final day = index + 1;
                  final selected = _daysOfWeek.contains(day);
                  const labels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                  return FilterChip(
                    label: Text(labels[index]),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        if (selected) {
                          _daysOfWeek.remove(day);
                        } else {
                          _daysOfWeek.add(day);
                        }
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final title = _titleController.text.trim();
                    if (title.isEmpty) {
                      return;
                    }

                    await widget.onSubmit(
                      RoutineEditorResult(
                        title: title,
                        description: _descriptionController.text.trim().isEmpty
                            ? null
                            : _descriptionController.text.trim(),
                        timeOfDay: _timeOfDay,
                        anchorTime: widget.initialAnchorTime,
                        daysOfWeek: _daysOfWeek,
                      ),
                    );

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(widget.routineId == null ? 'Crear rutina' : 'Guardar cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
