import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:learn2aid/features/presentation/global_widgets/play_button.dart';

class LessonContent extends StatelessWidget {
  final String imageUrl;
  final String description;
  final int durationInSeconds;
  final double progress;
  
  const LessonContent({
    super.key,
    this.imageUrl = '',
    this.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                       'Nullam tristique eros nec diam consectetur gravida. Nulla facilisi. '
                       'Vestibulum malesuada nisl tortor, tincidunt pulvinar massa lacinia ut.',
    this.durationInSeconds = 120,
    this.progress = 0.6,
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
            // Phần ảnh 
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
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
                  Positioned(
                    top: 10,
                    right: 10,
                    child: progressIndicator(progress),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Phần mô tả
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      Text(
                        '${(durationInSeconds / 60).floor()} min',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lexend',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(child: PlayButton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget progressIndicator(double value) {
    final int percent = (value * 100).round();
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff55c595)),
                ),
              ),
              Text(
                '$percent',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
