import 'package:flutter/material.dart';

class ConfirmHabitSheet extends StatefulWidget {
  final String habitTitle;
  final void Function(String confidenceLevel, String? notes) onConfirm;
  final VoidCallback? onCancel;

  const ConfirmHabitSheet({
    super.key,
    required this.habitTitle,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  State<ConfirmHabitSheet> createState() => _ConfirmHabitSheetState();
}

class _ConfirmHabitSheetState extends State<ConfirmHabitSheet> {
  String? _selectedOption;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, size: 48, color: Colors.green),
                  const SizedBox(height: 12),
                  Text(
                    '¿Completaste "${widget.habitTitle}"?',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cuéntanos cómo lo hiciste',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _OptionTile(
                    title: 'Confía en mí',
                    subtitle: 'Solo registro que lo completé',
                    icon: Icons.done,
                    selected: _selectedOption == 'trust_me',
                    onTap: () => setState(() => _selectedOption = 'trust_me'),
                  ),
                  const SizedBox(height: 12),
                  _OptionTile(
                    title: 'Subir foto',
                    subtitle: 'Evidencia con foto',
                    icon: Icons.camera_alt,
                    selected: _selectedOption == 'photo',
                    onTap: () => setState(() => _selectedOption = 'photo'),
                  ),
                ],
              ),
            ),
            if (_selectedOption != null) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notas (opcional)', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'Cómo te fue, dificultades, etc...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        widget.onCancel?.call();
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedOption == null
                          ? null
                          : () => widget.onConfirm(
                                _selectedOption!,
                                _notesController.text.trim().isEmpty
                                    ? null
                                    : _notesController.text.trim(),
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Confirmar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.indigo : Colors.grey.withOpacity(0.3),
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selected ? Colors.indigo.withOpacity(0.1) : Colors.transparent,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected
                    ? Colors.indigo.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.indigo : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          color: selected ? Colors.indigo : null,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
            Radio<bool>(
              value: true,
              groupValue: selected,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
