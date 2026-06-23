class RoutineQuickCardViewModel {
  final String title;
  final String? description;
  final double completionRate;
  final int completedCount;
  final int habitCount;

  const RoutineQuickCardViewModel({
    required this.title,
    this.description,
    required this.completionRate,
    required this.completedCount,
    required this.habitCount,
  });
}
