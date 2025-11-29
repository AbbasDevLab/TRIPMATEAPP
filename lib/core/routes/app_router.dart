import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/trips/presentation/pages/create_trip_page.dart';
import '../../features/trips/presentation/pages/trip_list_page.dart';
import '../../features/trips/presentation/pages/trip_detail_page.dart';
import '../../features/tours/presentation/pages/tour_discovery_page.dart';
import '../../features/tours/presentation/pages/tour_detail_page.dart';
import '../../features/community/presentation/pages/community_feed_page.dart';
import '../../features/chat/presentation/pages/chat_list_page.dart';
import '../../features/chat/presentation/pages/chat_conversation_page.dart';
import '../../features/ai/presentation/pages/ai_assistant_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/partner/presentation/pages/partner_portal_page.dart';
import '../../features/sos/presentation/pages/sos_page.dart';
import '../../features/community/presentation/pages/create_post_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/otp-verification',
        name: 'otp-verification',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final phone = state.uri.queryParameters['phone'] ?? '';
          final type = state.uri.queryParameters['type'] ?? 'email';
          return OTPVerificationPage(
            email: email,
            phone: phone,
            type: type,
          );
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      // Trips routes
      GoRoute(
        path: '/trips',
        name: 'trips',
        builder: (context, state) => const TripListPage(),
      ),
      GoRoute(
        path: '/trips/create',
        name: 'create-trip',
        builder: (context, state) => const CreateTripPage(),
      ),
      GoRoute(
        path: '/trips/:tripId',
        name: 'trip-detail',
        builder: (context, state) {
          final tripId = state.pathParameters['tripId'] ?? '';
          return TripDetailPage(tripId: tripId);
        },
      ),
      // Tours routes
      GoRoute(
        path: '/tours',
        name: 'tours',
        builder: (context, state) => const TourDiscoveryPage(),
      ),
      GoRoute(
        path: '/tours/:tourId',
        name: 'tour-detail',
        builder: (context, state) {
          final tourId = state.pathParameters['tourId'] ?? '';
          return TourDetailPage(tourId: tourId);
        },
      ),
      // Community routes
      GoRoute(
        path: '/community',
        name: 'community',
        builder: (context, state) => const CommunityFeedPage(),
      ),
      // Chat routes
      GoRoute(
        path: '/chat',
        name: 'chat-list',
        builder: (context, state) => const ChatListPage(),
      ),
      GoRoute(
        path: '/chat/:chatId',
        name: 'chat-conversation',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId'] ?? '';
          return ChatConversationPage(chatId: chatId);
        },
      ),
      // AI Assistant
      GoRoute(
        path: '/ai-assistant',
        name: 'ai-assistant',
        builder: (context, state) => const AIAssistantPage(),
      ),
      // Profile routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/profile/edit',
        name: 'edit-profile',
        builder: (context, state) => const EditProfilePage(),
      ),
      // Notifications
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      // Community create post
      GoRoute(
        path: '/community/create-post',
        name: 'create-post',
        builder: (context, state) => const CreatePostPage(),
      ),
      // Partner Portal
      GoRoute(
        path: '/partner',
        name: 'partner',
        builder: (context, state) => const PartnerPortalPage(),
      ),
      // SOS
      GoRoute(
        path: '/sos',
        name: 'sos',
        builder: (context, state) => const SOSPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});

