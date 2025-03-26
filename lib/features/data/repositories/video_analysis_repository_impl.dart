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
  // Cấu hình URL máy chủ backend - thay bằng IP thực tế khi triển khai
  // 10.0.2.2 là địa chỉ localhost trên emulator Android
  // 127.0.0.1 sẽ hoạt động trên web
  final String _baseUrl = 'http://192.168.1.248:8000'; 
  final http.Client _client;
  
  VideoAnalysisRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();
  
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
        // Đặt timeout cho request
        final streamedResponse = await request.send().timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw TimeoutException('Quá thời gian kết nối tới server');
          },
        );
        
        final response = await http.Response.fromStream(streamedResponse);
        
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          
          double scoreValue = 0.0;
          if (jsonData['point'] != null) {
            try {
              // Nếu point là String, cố gắng chuyển đổi sang double
              if (jsonData['point'] is String) {
                scoreValue = double.tryParse(jsonData['point']) ?? 0.0;
              } else {
                scoreValue = (jsonData['point'] as num).toDouble();
              }
            } catch (e) {
              print('Lỗi khi chuyển đổi point thành số: $e');
              scoreValue = 0.0;
            }
          }
          
          return VideoAnalysisModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            analysis: jsonData['comment'] ?? 'Phân tích video hoàn tất',
            score: scoreValue,
            comments: [jsonData['comment'] ?? 'Không có nhận xét chi tiết'],
            suggestions: [
              'Hãy tập trung vào kỹ thuật đúng.',
              'Giữ nhịp đều đặn khi thực hiện động tác.',
              'Đảm bảo tư thế chuẩn trong suốt quá trình thực hiện.'
            ],
            createdAt: DateTime.now(),
          );
        } else {
          // Log lỗi và fallback về dữ liệu mẫu
          print('Lỗi HTTP: ${response.statusCode} - ${response.body}');
          return _getFallbackAnalysis('Không thể kết nối tới server phân tích');
        }
      } catch (connError) {
        print('Lỗi kết nối: $connError');
        
        if (connError is TimeoutException) {
          throw connError;
        } else {
          throw NetworkException('Không thể kết nối tới server: $connError');
        }
      }
    } catch (e) {
      print('Lỗi xử lý video: $e');
      
      if (e is TimeoutException || e is NetworkException) {
        throw e;
      } else {
        throw VideoAnalysisException('Lỗi xử lý video: $e');
      }
    }
  }
  
  // Tạo phân tích mẫu khi có lỗi
  VideoAnalysis _getFallbackAnalysis(String errorMessage) {
    return VideoAnalysisModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      analysis: 'Phân tích offline',
      score: 75.0,
      comments: [errorMessage, 'Đang sử dụng phân tích offline'],
      suggestions: [
        'Kiểm tra kết nối mạng của bạn',
        'Đảm bảo video có độ dài phù hợp (5-30 giây)',
        'Thử lại sau vài phút'
      ],
      createdAt: DateTime.now(),
    );
  }
  
  @override
  Future<bool> saveAnalysisResult(VideoAnalysis analysis) async {
    try {
      // Có thể triển khai lưu vào local storage hoặc gửi lên server
      // Hiện tại chỉ trả về thành công
      return true;
    } catch (e) {
      throw VideoAnalysisException('Lỗi khi lưu kết quả: $e');
    }
  }
  
  @override
  Future<List<VideoAnalysis>> getAnalysisHistory() async {
    try {
      // TODO: Triển khai lấy lịch sử phân tích từ local hoặc server
      return List.generate(
        5,
        (index) => VideoAnalysisModel(
          id: 'history_${index}_${DateTime.now().millisecondsSinceEpoch}',
          analysis: 'Phân tích trước đó #$index',
          score: 70.0 + (index * 5.0),
          comments: ['Đây là lịch sử phân tích'],
          suggestions: ['Cải thiện kỹ thuật qua các bài thực hành'],
          createdAt: DateTime.now().subtract(Duration(days: index)),
        ),
      );
    } catch (e) {
      throw VideoAnalysisException('Lỗi khi lấy lịch sử phân tích: $e');
    }
  }
} 