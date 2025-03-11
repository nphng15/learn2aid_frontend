import '../../entities/video.dart';
import '../../repositories/video_repository.dart';

class RecordVideoUseCase {
  final VideoRepository repository;

  RecordVideoUseCase(this.repository);

  Future<Video?> call() {
    return repository.recordVideo();
  }
}
