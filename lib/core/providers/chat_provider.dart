import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message_model.dart';
import '../services/api_service.dart';
import '../services/socket_service.dart';

final chatListProvider = FutureProvider<List<ChatModel>>((ref) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('/chat');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => ChatModel.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});

final chatMessagesProvider = FutureProvider.family<List<ChatMessageModel>, String>((ref, chatId) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('/chat/$chatId/messages');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => ChatMessageModel.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});

final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService();
});

