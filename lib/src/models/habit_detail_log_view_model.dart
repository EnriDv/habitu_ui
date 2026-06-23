class HabitDetailLogViewModel {
  final DateTime completedAt;
  final String? notes;
  final String? evidencePath;

  const HabitDetailLogViewModel({
    required this.completedAt,
    required this.notes,
    required this.evidencePath,
  });
}
