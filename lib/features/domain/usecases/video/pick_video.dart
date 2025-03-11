import '../../entities/video.dart';
import '../../repositories/video_repository.dart';

class PickVideoUseCase {
  final VideoRepository repository;

  PickVideoUseCase(this.repository);

  Future<Video?> call() {
    return repository.pickVideo();
  }
}
