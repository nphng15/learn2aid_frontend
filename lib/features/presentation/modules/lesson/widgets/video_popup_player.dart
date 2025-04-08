import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wakelock/wakelock.dart';

class VideoPopupPlayer extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String videoId;
  final Function(String, double) onProgressUpdate;
  
  const VideoPopupPlayer({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.videoId,
    required this.onProgressUpdate,
  });

  @override
  State<VideoPopupPlayer> createState() => _VideoPopupPlayerState();
}

class _VideoPopupPlayerState extends State<VideoPopupPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    
    try {
      await _videoPlayerController.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xff215273),
          handleColor: const Color(0xff215273),
          bufferedColor: const Color(0xff215273).withOpacity(0.5),
          backgroundColor: Colors.grey,
        ),
        showControls: true,
        allowFullScreen: true,
        allowMuting: true,
        showOptions: false,
      );
      
      // Thêm listener cho video player để xử lý sự kiện phát/dừng và cập nhật tiến trình
      _videoPlayerController.addListener(_videoListener);
      
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Lỗi khởi tạo video player: $e');
    }
  }
  
  // Hàm xử lý sự kiện video
  void _videoListener() {
    if (_videoPlayerController.value.isPlaying) {
      // Video đang phát
      Wakelock.enable();
      
      // Cập nhật tiến trình xem video
      final position = _videoPlayerController.value.position;
      final duration = _videoPlayerController.value.duration;
      if (duration.inSeconds > 0) {
        final progress = position.inSeconds / duration.inSeconds;
        widget.onProgressUpdate(widget.videoId, progress);
      }
    } else {
      // Video đã dừng
      Wakelock.disable();
    }
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_videoListener);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header với tiêu đề và nút đóng
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Video player
            Expanded(
              child: _isInitialized && _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 