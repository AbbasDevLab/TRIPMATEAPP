import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tour_model.dart';
import '../services/api_service.dart';
import '../config/app_config.dart';
import 'mock_data_provider.dart';

final tourListProvider = FutureProvider<List<TourModel>>((ref) async {
  // Use mock data in test mode
  if (AppConfig.testMode) {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return MockDataProvider.getMockTours();
  }

  final apiService = ApiService();
  try {
    final response = await apiService.get('/tours');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => TourModel.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});

final tourProvider = FutureProvider.family<TourModel?, String>((ref, tourId) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('/tours/$tourId');
    if (response.statusCode == 200) {
      return TourModel.fromJson(response.data);
    }
    return null;
  } catch (e) {
    return null;
  }
});

