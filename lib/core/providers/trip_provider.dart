import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trip_model.dart';
import '../services/api_service.dart';
import '../config/app_config.dart';
import 'mock_data_provider.dart';

final tripListProvider = FutureProvider<List<TripModel>>((ref) async {
  // Use mock data in test mode
  if (AppConfig.testMode) {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return MockDataProvider.getMockTrips();
  }

  final apiService = ApiService();
  try {
    final response = await apiService.get('/trips');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => TripModel.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});

final tripProvider = FutureProvider.family<TripModel?, String>((ref, tripId) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('/trips/$tripId');
    if (response.statusCode == 200) {
      return TripModel.fromJson(response.data);
    }
    return null;
  } catch (e) {
    return null;
  }
});

