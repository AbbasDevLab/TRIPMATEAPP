import 'package:dio/dio.dart';
import '../config/app_config.dart';

class AIService {
  final Dio _dio = Dio();

  AIService() {
    // Configure Dio for OpenAI API
    _dio.options.baseUrl = 'https://api.openai.com/v1';
    _dio.options.headers = {
      'Authorization': 'Bearer ${AppConfig.openAIApiKey}',
      'Content-Type': 'application/json',
    };
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    
    // Add logging interceptor for debugging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<String> generateItinerary({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required String category,
    String? budget,
    String? preferences,
  }) async {
    try {
      // Validate API key
      if (AppConfig.openAIApiKey.isEmpty || AppConfig.openAIApiKey == 'YOUR_OPENAI_API_KEY') {
        throw Exception('OpenAI API key is not configured. Please set it in app_config.dart');
      }

      final prompt = _buildItineraryPrompt(
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        category: category,
        budget: budget,
        preferences: preferences,
      );

      print('🤖 Generating itinerary for $destination...');
      print('🔑 Using model: ${AppConfig.openAIModel}');

      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConfig.openAIModel,
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a helpful travel assistant for FCCU students. Provide detailed, practical, and budget-friendly travel itineraries.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 2000,
        },
      );

      if (response.statusCode == 200) {
        final content = response.data['choices']?[0]?['message']?['content'] as String?;
        if (content != null) {
          print('✅ Itinerary generated successfully');
          return content;
        } else {
          throw Exception('Invalid response format from OpenAI API');
        }
      } else {
        throw Exception('OpenAI API returned status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ OpenAI API Error: ${e.message}');
      if (e.response != null) {
        final errorData = e.response?.data;
        final errorMessage = errorData?['error']?['message'] ?? e.message ?? 'Unknown error';
        print('📄 Error details: $errorData');
        throw Exception('OpenAI API error: $errorMessage');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw Exception('Failed to generate itinerary: $e');
    }
  }

  Future<String> chatCompletion(String message, List<Map<String, String>> history) async {
    try {
      // Validate API key
      if (AppConfig.openAIApiKey.isEmpty || AppConfig.openAIApiKey == 'YOUR_OPENAI_API_KEY') {
        throw Exception('OpenAI API key is not configured. Please set it in app_config.dart');
      }

      final messages = [
        {
          'role': 'system',
          'content':
              'You are a helpful travel assistant for FCCU students. Provide friendly, informative, and practical travel advice.',
        },
        ...history,
        {
          'role': 'user',
          'content': message,
        },
      ];

      print('🤖 Sending request to OpenAI API...');
      print('📝 Message: $message');
      print('🔑 Using model: ${AppConfig.openAIModel}');

      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConfig.openAIModel,
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 1000,
        },
      );

      if (response.statusCode == 200) {
        final content = response.data['choices']?[0]?['message']?['content'] as String?;
        if (content != null) {
          print('✅ Received response from OpenAI');
          return content;
        } else {
          throw Exception('Invalid response format from OpenAI API');
        }
      } else {
        throw Exception('OpenAI API returned status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ OpenAI API Error: ${e.message}');
      if (e.response != null) {
        final errorData = e.response?.data;
        final errorMessage = errorData?['error']?['message'] ?? e.message ?? 'Unknown error';
        print('📄 Error details: $errorData');
        throw Exception('OpenAI API error: $errorMessage');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw Exception('Failed to get AI response: $e');
    }
  }

  String _buildItineraryPrompt({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required String category,
    String? budget,
    String? preferences,
  }) {
    final days = endDate.difference(startDate).inDays;
    var prompt = 'Create a $days-day travel itinerary for $destination. '
        'Trip category: $category. ';

    if (budget != null) {
      prompt += 'Budget: $budget. ';
    }

    if (preferences != null) {
      prompt += 'Preferences: $preferences. ';
    }

    prompt += 'Include daily activities, recommended places to visit, '
        'restaurant suggestions, and transportation tips. '
        'Format the response as a structured itinerary with day-by-day breakdown.';

    return prompt;
  }
}

