import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../models/quiz_model.dart';
import '../models/question_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final FirebaseFirestore firestore;

  QuizRepositoryImpl({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<QuizEntity>> getQuizzes() async {
    try {
      final QuerySnapshot quizSnapshot = await firestore.collection('quizzes').get();
      
      return quizSnapshot.docs
          .map((doc) => QuizModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Lỗi khi tải danh sách quiz: $e');
    }
  }

  @override
  Future<QuizEntity?> getQuizById(String id) async {
    try {
      final DocumentSnapshot quizDoc = await firestore.collection('quizzes').doc(id).get();
      
      if (!quizDoc.exists) {
        return null;
      }
      
      return QuizModel.fromFirestore(quizDoc);
    } catch (e) {
      throw Exception('Lỗi khi tải quiz: $e');
    }
  }

  @override
  Future<List<QuestionEntity>> getQuestionsForQuiz(String quizId) async {
    try {
      final QuerySnapshot questionSnapshot = await firestore
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .get();

      return questionSnapshot.docs
          .map((doc) => QuestionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Lỗi khi tải câu hỏi: $e');
    }
  }

  @override
  Future<void> submitQuizResult({
    required String userId,
    required String userName,
    required String quizId,
    required String quizTitle,
    required int score,
    required int totalQuestions,
    required List<int> answers,
    required int timeSpent,
  }) async {
    try {
      await firestore.collection('quiz_results').add({
        'userId': userId,
        'userName': userName,
        'quizId': quizId,
        'quizTitle': quizTitle,
        'score': score,
        'totalQuestions': totalQuestions,
        'percentageScore': (score / totalQuestions * 100).toInt(),
        'answers': answers,
        'timeSpent': timeSpent,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Lỗi khi nộp kết quả: $e');
    }
  }
} 