import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:path/path.dart' as path;

import '../../domain/repositories/video_analysis_repository.dart';
import '../../domain/entities/video_analysis.dart';
import '../models/video_analysis_model.dart';
import '../../../core/error/exceptions.dart';

class VideoAnalysisRepositoryImpl implements VideoAnalysisRepository {
  final String _baseUrl = 'https://learn2aid-ai-service.onrender.com'; 
  
  @override
  Future<VideoAnalysis> analyzeVideo(File videoFile, {String movementType = 'cpr'}) async {
    try {
      // Kết nối với API endpoint predict của backend
      final uri = Uri.parse('$_baseUrl/predict');
      
      var request = http.MultipartRequest('POST', uri);
      
      final fileName = path.basename(videoFile.path);
      
      // Thêm file video vào request
      request.files.add(
        await http.MultipartFile.fromPath('file', videoFile.path, filename: fileName),
      );
      
      // Thêm tham số movement_name từ movementType được chọn
      request.fields['movement_name'] = movementType;
      
      try {
        final streamedResponse = await request.send();
        
        final response = await http.Response.fromStream(streamedResponse);
        
        if (response.statusCode == 200) {
          final decodedBody = utf8.decode(response.bodyBytes);  
          final jsonData = json.decode(decodedBody);
          
          print('API Response: $jsonData');
          // Chuyển đổi dữ liệu JSON sang VideoAnalysis thông qua VideoAnalysisModel
          return VideoAnalysisModel.fromJson(jsonData);
        } else {
          
          try {
            final errorData = json.decode(response.body);
            final errorMessage = errorData['error'] ?? 'Unknown server error';

            return _getFallbackAnalysis('Server error: $errorMessage');
          } catch (e) {
            // Nếu không phải JSON, trả về lỗi HTTP
            return _getFallbackAnalysis('HTTP Error: ${response.statusCode}');
          }
        }
      } catch (connError) {
        if (connError is TimeoutException) {
          throw connError;
        } else {
          throw NetworkException('Cannot connect to server: $connError');
        }
      }
    } catch (e) {  
      if (e is TimeoutException || e is NetworkException) {
        throw e;
      } else {
        throw VideoAnalysisException('Error processing video: $e');
      }
    }
  }
  
  // Tạo phân tích mẫu khi có lỗi
  VideoAnalysis _getFallbackAnalysis(String errorMessage) {
    return VideoAnalysisModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      analysis: 'Phân tích offline',
      score: 0.0,
      strengths: ['Chế độ ngoại tuyến vẫn hoạt động'],
      improvements: [
        'Kiểm tra kết nối mạng của bạn',
        'Đảm bảo video có độ dài phù hợp (5-30 giây)',
        'Thử lại sau vài phút'
      ],
      scoreBreakdown: {
        'offline_mode': 0.0,
      },
      createdAt: DateTime.now(),
    );
  }
  
  // @override
  // Future<bool> saveAnalysisResult(VideoAnalysis analysis) async {
  //   try {
  //     // Có thể triển khai lưu vào local storage hoặc gửi lên server
  //     // Hiện tại chỉ trả về thành công
  //     return true;
  //   } catch (e) {
  //     throw VideoAnalysisException('Lỗi khi lưu kết quả: $e');
  //   }
  // }
  
  // @override
  // Future<List<VideoAnalysis>> getAnalysisHistory() async {
  //   try {
  //     // TODO: Triển khai lấy lịch sử phân tích từ local hoặc server
  //     return List.generate(
  //       5,
  //       (index) => VideoAnalysisModel(
  //         id: 'history_${index}_${DateTime.now().millisecondsSinceEpoch}',
  //         analysis: 'Phân tích trước đó #$index',
  //         score: 70.0 + (index * 5.0),
  //         strengths: ['Lưu trữ lịch sử phân tích thành công'],
  //         improvements: ['Cải thiện kỹ thuật qua các bài thực hành'],
  //         scoreBreakdown: {
  //           'historical_data': 70.0 + (index * 5.0),
  //         },
  //         createdAt: DateTime.now().subtract(Duration(days: index)),
  //       ),
  //     );
  //   } catch (e) {
  //     throw VideoAnalysisException('Lỗi khi lấy lịch sử phân tích: $e');
  //   }
//  }
} 