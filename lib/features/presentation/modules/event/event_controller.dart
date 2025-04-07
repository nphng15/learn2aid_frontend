import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../domain/entities/event_entity.dart';
import '../../../domain/repositories/event_repository.dart';

class EventController extends GetxController {
  final EventRepository _repository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  EventController(this._repository);
  
  final RxList<Event> events = <Event>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      final eventsList = await _repository.getEvents();
      events.value = eventsList;
    } catch (e) {
      errorMessage.value = 'Không thể tải danh sách sự kiện: $e';
      print('Lỗi khi tải sự kiện: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String get currentUserId {
    return _auth.currentUser?.uid ?? '';
  }

  bool hasUserJoinedEvent(Event event) {
    return event.hasUserJoined(currentUserId);
  }

  Future<void> joinEvent(Event event) async {
    if (currentUserId.isEmpty) {
      errorMessage.value = 'Bạn cần đăng nhập để tham gia sự kiện';
      return;
    }

    if (hasUserJoinedEvent(event)) {
      errorMessage.value = 'Bạn đã tham gia sự kiện này';
      return;
    }

    isLoading.value = true;
    try {
      final success = await _repository.joinEvent(event.id, currentUserId);
      
      if (success) {
        // Cập nhật danh sách events
        final index = events.indexWhere((e) => e.id == event.id);
        if (index != -1) {
          final updatedEvent = event.copyWith(
            joinedUsers: [...event.joinedUsers, currentUserId],
          );
          events[index] = updatedEvent;
          events.refresh();
        }
      } else {
        errorMessage.value = 'Không thể tham gia sự kiện';
      }
    } catch (e) {
      errorMessage.value = 'Không thể tham gia sự kiện: $e';
      print('Lỗi khi tham gia sự kiện: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
} 