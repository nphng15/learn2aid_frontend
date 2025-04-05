import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/entities/video_analysis.dart';
import './analysis_details_page.dart';

class AnalysisResultDialog extends StatelessWidget {
  final VideoAnalysis analysis;
  final VoidCallback? onSave;
  
  const AnalysisResultDialog({
    super.key,
    required this.analysis,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tiêu đề kết quả
            const Text(
              'Analysis Results',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
                color: Color(0xff215273),
              ),
            ),
            const SizedBox(height: 24),
            
            // Điểm số với CircularProgressIndicator
            SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CircularProgressIndicator(
                      value: analysis.score / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xff55c595),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${analysis.score.round()}',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff55c595),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Mô tả kết quả
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                _getShortDescription(analysis),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  height: 1.5,
                  color: Color(0xff333333),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Nút điều hướng
            Row(
              children: [
                // View details button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Đóng dialog trước
                      Navigator.of(context).pop();
                      
                      // Mở trang chi tiết
                      Get.to(() => AnalysisDetailsPage(analysis: analysis));
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff215273)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'View details',
                      style: TextStyle(
                        color: Color(0xff215273),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Continue button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (onSave != null) onSave!();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff55c595),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // Trả về mô tả ngắn gọn dựa trên phân tích
  String _getShortDescription(VideoAnalysis analysis) {
    // Nếu có điểm mạnh thì dùng điểm mạnh đầu tiên, ngược lại dùng mô tả chung
    if (analysis.strengths.isNotEmpty) {
      return analysis.strengths.first;
    } else if (analysis.analysis.isNotEmpty) {
      return analysis.analysis;
    }
    return "Your movement has been analyzed!";
  }
} 