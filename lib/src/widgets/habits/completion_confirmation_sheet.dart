import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/completion_confirmation_result.dart';
import '../../tokens/habitu_colors.dart';
import '../core/habitu_button.dart';

enum HabitEvidenceSource { camera, gallery }

class CompletionConfirmationSheet extends StatefulWidget {
  final String habitTitle;
  final Future<String?> Function(HabitEvidenceSource source) onRequestEvidence;
  final void Function(CompletionConfirmationResult result) onSubmit;
  final VoidCallback onCancel;

  const CompletionConfirmationSheet({
    super.key,
    required this.habitTitle,
    required this.onRequestEvidence,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<CompletionConfirmationSheet> createState() => _CompletionConfirmationSheetState();
}

class _CompletionConfirmationSheetState extends State<CompletionConfirmationSheet> {
  final TextEditingController _notesController = TextEditingController();
  String? _imagePath;
  bool _isImageLoading = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickEvidence(HabitEvidenceSource source) async {
    setState(() {
      _isImageLoading = true;
    });

    try {
      final path = await widget.onRequestEvidence(source);
      if (!mounted || path == null || path.isEmpty) {
        return;
      }
      setState(() {
        _imagePath = path;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isImageLoading = false;
        });
      }
    }
  }

  Future<void> _showEvidencePicker() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: HabituColors.surfaceContainerHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Tomar foto'),
              onTap: () async {
                Navigator.pop(context);
                await _pickEvidence(HabitEvidenceSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Elegir de la galeria'),
              onTap: () async {
                Navigator.pop(context);
                await _pickEvidence(HabitEvidenceSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottomInset),
        decoration: BoxDecoration(
          color: HabituColors.surfaceContainerHigh,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HabituColors.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                backgroundColor: HabituColors.tertiary,
                radius: 28,
                child: Icon(Icons.check, color: HabituColors.onTertiary, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                '¿Cumpliste con este hábito?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.habitTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: HabituColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  hintText: 'Agrega una nota u observación opcional',
                  prefixIcon: Icon(Icons.edit_note),
                ),
                minLines: 1,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              if (_imagePath != null) ...[
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: HabituColors.tertiary.withOpacity(0.5),
                      width: 1.5,
                    ),
                    image: DecorationImage(
                      image: FileImage(File(_imagePath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton.icon(
                    onPressed: _isImageLoading ? null : _showEvidencePicker,
                    icon: const Icon(Icons.refresh, color: HabituColors.tertiary, size: 16),
                    label: const Text(
                      'Cambiar evidencia',
                      style: TextStyle(color: HabituColors.tertiary),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (_isImageLoading) ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CircularProgressIndicator(color: HabituColors.tertiary),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              ElevatedButton.icon(
                onPressed: _isImageLoading
                    ? null
                    : (_imagePath != null
                        ? () => widget.onSubmit(
                              CompletionConfirmationResult(
                                notes: _notesController.text.trim().isEmpty
                                    ? null
                                    : _notesController.text.trim(),
                                hasEvidence: true,
                                photoPath: _imagePath,
                              ),
                            )
                        : _showEvidencePicker),
                icon: Icon(_imagePath != null ? Icons.check : Icons.add_a_photo_outlined),
                label: Text(
                  _imagePath != null ? 'Completar con evidencia' : 'Adjuntar evidencia',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _imagePath != null ? HabituColors.primary : HabituColors.tertiary,
                  foregroundColor:
                      _imagePath != null ? Colors.white : HabituColors.onTertiary,
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              const SizedBox(height: 12),
              if (_imagePath == null) ...[
                HabituButton.outlined(
                  label: 'Marcar sin evidencia',
                  onPressed: () => widget.onSubmit(
                    CompletionConfirmationResult(
                      notes: _notesController.text.trim().isEmpty
                          ? null
                          : _notesController.text.trim(),
                      hasEvidence: false,
                      photoPath: null,
                    ),
                  ),
                  icon: Icons.done_all,
                  fullWidth: true,
                ),
                const SizedBox(height: 16),
              ],
              TextButton(
                onPressed: widget.onCancel,
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: HabituColors.onSurfaceVariant.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
