import '../entities/video.dart';

abstract class VideoRepository {
  Future<Video?> pickVideo();
  Future<Video?> recordVideo();
}
