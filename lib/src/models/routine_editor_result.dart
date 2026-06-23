class RoutineEditorResult {
  final String title;
  final String? description;
  final String timeOfDay;
  final String? anchorTime;
  final List<int> daysOfWeek;

  const RoutineEditorResult({
    required this.title,
    required this.description,
    required this.timeOfDay,
    required this.anchorTime,
    required this.daysOfWeek,
  });
}
