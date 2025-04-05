class VideoModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String category;
  final int duration;
  final String uploadedBy;
  final String uploaderName;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.category,
    required this.duration,
    required this.uploadedBy,
    required this.uploaderName,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map, String id) {
    return VideoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      category: map['category'] ?? '',
      duration: map['duration'] ?? 0,
      uploadedBy: map['uploadedBy'] ?? '',
      uploaderName: map['uploaderName'] ?? '',
    );
  }

  String get formattedDuration {
    final minutes = (duration / 60).floor();
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  int get durationInSeconds {
    return duration;
  }
} 