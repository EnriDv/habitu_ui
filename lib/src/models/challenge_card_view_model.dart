class ChallengeCardViewModel {
  final String title;
  final String? description;
  final String category;
  final String dateRangeLabel;
  final String participantsLabel;
  final bool isJoined;
  final bool isFull;

  const ChallengeCardViewModel({
    required this.title,
    required this.description,
    required this.category,
    required this.dateRangeLabel,
    required this.participantsLabel,
    required this.isJoined,
    required this.isFull,
  });
}
