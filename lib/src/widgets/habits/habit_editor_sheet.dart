import 'package:flutter/material.dart';

import '../../models/habit_editor_category_option.dart';
import '../../models/habit_editor_result.dart';
import '../../tokens/habitu_colors.dart';

class HabitEditorSheet extends StatefulWidget {
  final String title;
  final String? initialTitle;
  final String? initialDescription;
  final String initialIcon;
  final String initialColorHex;
  final List<int> initialDaysOfWeek;
  final bool initialIsPublic;
  final TimeOfDay initialReminderTime;
  final List<HabitEditorCategoryOption> categories;
  final List<String> availableColorHexes;
  final Future<bool> Function(HabitEditorResult result) onSubmit;
  final Future<bool> Function()? onDelete;

  const HabitEditorSheet({
    super.key,
    required this.title,
    required this.initialTitle,
    required this.initialDescription,
    required this.initialIcon,
    required this.initialColorHex,
    required this.initialDaysOfWeek,
    required this.initialIsPublic,
    required this.initialReminderTime,
    required this.categories,
    required this.availableColorHexes,
    required this.onSubmit,
    this.onDelete,
  });

  @override
  State<HabitEditorSheet> createState() => _HabitEditorSheetState();
}

class _HabitEditorSheetState extends State<HabitEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late String _selectedEmoji;
  late String _selectedColorHex;
  late List<int> _selectedDays;
  late bool _isPublic;
  late TimeOfDay _reminderTime;
  bool _isSubmitting = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descriptionController = TextEditingController(text: widget.initialDescription ?? '');
    _selectedEmoji = widget.initialIcon;
    _selectedColorHex = widget.initialColorHex;
    _selectedDays = List<int>.from(widget.initialDaysOfWeek);
    _isPublic = widget.initialIsPublic;
    _reminderTime = widget.initialReminderTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final ok = await widget.onSubmit(
      HabitEditorResult(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        icon: _selectedEmoji,
        colorHex: _selectedColorHex,
        daysOfWeek: List<int>.from(_selectedDays),
        isPublic: _isPublic,
        reminderTime: _reminderTime,
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    if (ok) {
      Navigator.pop(context);
    }
  }

  Future<void> _delete() async {
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: HabituColors.surfaceContainerHigh,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Guardar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HabituColors.primary,
                      ),
                    ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            children: [
              TextFormField(
                controller: _titleController,
                autofocus: true,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                decoration: const InputDecoration(
                  hintText: '¿Qué quieres construir hoy?',
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Agrega una descripción opcional...',
                  filled: true,
                ),
              ),
              const SizedBox(height: 24),
              Text('Categoría:', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 10),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = widget.categories[index];
                    final isSelected = _selectedEmoji == category.emoji;
                    return ChoiceChip(
                      label: Text('${category.emoji} ${category.label}'),
                      selected: isSelected,
                      selectedColor: HabituColors.primary.withOpacity(0.2),
                      side: BorderSide(
                        color: isSelected
                            ? HabituColors.primary
                            : Colors.white.withOpacity(0.05),
                      ),
                      onSelected: (_) {
                        setState(() {
                          _selectedEmoji = category.emoji;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text('Color de tarjeta:', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 12),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.availableColorHexes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final hex = widget.availableColorHexes[index];
                    final color = Color(int.parse(hex.replaceAll('#', '0xFF')));
                    final isSelected = _selectedColorHex == hex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorHex = hex;
                        });
                      },
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 2.5)
                              : Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Frecuencia (días de la semana):',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final dayNumber = index + 1;
                  final isSelected = _selectedDays.contains(dayNumber);
                  const dayNames = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            if (_selectedDays.length > 1) {
                              _selectedDays.remove(dayNumber);
                            }
                          } else {
                            _selectedDays.add(dayNumber);
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 44,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? HabituColors.primary.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? HabituColors.primary
                                : Colors.white.withOpacity(0.05),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          dayNames[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? HabituColors.primary
                                : HabituColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.notifications_active_outlined,
                  color: HabituColors.primary,
                ),
                title: const Text('Recordatorio'),
                subtitle: Text(_reminderTime.format(context)),
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: _selectTime,
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Hacer público para amigos'),
                subtitle: Text(
                  _isPublic
                      ? 'Tus amigos verán tu racha y progreso.'
                      : 'Hábito privado. Solo tú podrás verlo.',
                  style: const TextStyle(fontSize: 12),
                ),
                value: _isPublic,
                onChanged: (value) {
                  setState(() {
                    _isPublic = value;
                  });
                },
                activeColor: HabituColors.primary,
              ),
              if (widget.onDelete != null) ...[
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _isDeleting ? null : _delete,
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
            ],
          ),
        ),
      ),
    );
  }
}
