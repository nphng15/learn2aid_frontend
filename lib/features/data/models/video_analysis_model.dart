import '../../domain/entities/video_analysis.dart';

class VideoAnalysisModel extends VideoAnalysis {
  VideoAnalysisModel({
    required String id,
    required String analysis, 
    required double score,
    required List<String> comments,
    required List<String> suggestions,
    required DateTime createdAt,
  }) : super(
    id: id,
    analysis: analysis,
    score: score,
    comments: comments,
    suggestions: suggestions,
    createdAt: createdAt,
  );

  factory VideoAnalysisModel.fromJson(Map<String, dynamic> json) {
    return VideoAnalysisModel(
      id: json['id'] ?? '',
      analysis: json['analysis'] ?? '',
      score: (json['score'] ?? 0.0).toDouble(),
      comments: List<String>.from(json['comments'] ?? []),
      suggestions: List<String>.from(json['suggestions'] ?? []),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'analysis': analysis,
      'score': score,
      'comments': comments,
      'suggestions': suggestions,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 