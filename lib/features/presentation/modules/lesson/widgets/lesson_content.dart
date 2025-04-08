import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import '../../dashboard/controllers/video_controller.dart';
import './video_popup_player.dart';

class LessonContent extends StatelessWidget {
  final String imageUrl;
  final String description;
  final int durationInSeconds;
  final String title;
  final String category;
  final String videoId;
  final String videoUrl;
  final VideoController? videoController;
  
  const LessonContent({
    super.key,
    this.imageUrl = '',
    this.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                       'Nullam tristique eros nec diam consectetur gravida. Nulla facilisi. '
                       'Vestibulum malesuada nisl tortor, tincidunt pulvinar massa lacinia ut.',
    this.durationInSeconds = 120,
    this.title = 'Tiêu đề video',
    this.category = 'Phân loại',
    this.videoId = '',
    this.videoUrl = '',
    this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, 
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        height: MediaQuery.of(context).size.height * 0.61, 
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xff215273), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header với tiêu đề
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Phần ảnh - giảm flex để thu nhỏ kích thước còn khoảng 1/3 card
            Expanded(
              flex: 3, // Giảm từ 5 xuống 3 (chiếm khoảng 1/3 của card)
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: imageUrl.isNotEmpty 
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: const Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                  ),
                  // Hiển thị danh mục ở góc dưới bên trái đè lên video
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff215273),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10, // Giảm từ 12 xuống 10
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // Giảm từ 10 xuống 8
            // Phần mô tả - tăng flex để hiển thị nhiều nội dung hơn
            Expanded(
              flex: 6, // Tăng từ 4 lên 6 (chiếm khoảng 2/3 của card)
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mô tả',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      Text(
                        '${(durationInSeconds / 60).floor()} phút',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lexend',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6), 
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Nút xem video
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (videoUrl.isNotEmpty && videoController != null) {
                          // Hiển thị popup video player thay vì mở trình duyệt
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => VideoPopupPlayer(
                              videoUrl: videoUrl,
                              title: title,
                              videoId: videoId,
                              onProgressUpdate: (id, progress) {
                                videoController!.updateVideoProgress(id, progress);
                              },
                            ),
                          );
                          
                          // Cập nhật video đang xem
                          videoController!.addToInProgress(videoId);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff55c595),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Xem video',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
