class VideoAnalysis {
  final String id;
  final String analysis;
  final double score;
  final List<String> comments;
  final List<String> suggestions;
  final DateTime createdAt;

  VideoAnalysis({
    required this.id,
    required this.analysis,
    required this.score,
    required this.comments,
    required this.suggestions,
    required this.createdAt,
  });
} 