import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_post_model.dart';
import '../services/api_service.dart';
import '../config/app_config.dart';
import 'mock_data_provider.dart';

final communityPostsProvider = FutureProvider<List<CommunityPostModel>>((ref) async {
  // Use mock data in test mode
  if (AppConfig.testMode) {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return MockDataProvider.getMockPosts();
  }

  final apiService = ApiService();
  try {
    final response = await apiService.get('/community/posts');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => CommunityPostModel.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});

final postProvider = FutureProvider.family<CommunityPostModel?, String>((ref, postId) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('/community/posts/$postId');
    if (response.statusCode == 200) {
      return CommunityPostModel.fromJson(response.data);
    }
    return null;
  } catch (e) {
    return null;
  }
});

final postCommentsProvider = FutureProvider.family<List<PostCommentModel>, String>((ref, postId) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('/community/posts/$postId/comments');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => PostCommentModel.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});

