import '../models/trip_model.dart';
import '../models/tour_model.dart';
import '../models/community_post_model.dart';

/// Mock data providers for test mode
class MockDataProvider {
  static List<TripModel> getMockTrips() {
    return [
      TripModel(
        id: '1',
        userId: 'user1',
        title: 'Summer Adventure in Northern Areas',
        destination: 'Hunza Valley',
        startDate: DateTime.now().add(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 37)),
        category: TripCategory.adventure,
        type: TripType.group,
        budget: 50000,
        description: 'Explore the beautiful Hunza Valley with friends',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      TripModel(
        id: '2',
        userId: 'user1',
        title: 'Cultural Tour of Lahore',
        destination: 'Lahore',
        startDate: DateTime.now().add(const Duration(days: 15)),
        endDate: DateTime.now().add(const Duration(days: 18)),
        category: TripCategory.cultural,
        type: TripType.family,
        budget: 25000,
        description: 'Discover the rich history and culture of Lahore',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }

  static List<TourModel> getMockTours() {
    return [
      TourModel(
        id: '1',
        guideId: 'guide1',
        title: 'Naran Kaghan Valley Tour',
        destination: 'Naran, Kaghan',
        description: 'Experience the breathtaking beauty of Naran and Kaghan valleys',
        startDate: DateTime.now().add(const Duration(days: 20)),
        endDate: DateTime.now().add(const Duration(days: 23)),
        price: 15000,
        maxParticipants: 20,
        currentParticipants: 12,
        images: [],
        rating: 4.5,
        reviewCount: 45,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TourModel(
        id: '2',
        guideId: 'guide2',
        title: 'Skardu Adventure Package',
        destination: 'Skardu',
        description: 'Explore Skardu with experienced guides',
        startDate: DateTime.now().add(const Duration(days: 45)),
        endDate: DateTime.now().add(const Duration(days: 50)),
        price: 25000,
        maxParticipants: 15,
        currentParticipants: 8,
        images: [],
        rating: 4.8,
        reviewCount: 32,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TourModel(
        id: '3',
        guideId: 'guide3',
        title: 'Murree Hill Station Tour',
        destination: 'Murree',
        description: 'Relaxing weekend getaway to Murree',
        startDate: DateTime.now().add(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 12)),
        price: 8000,
        maxParticipants: 25,
        currentParticipants: 25,
        images: [],
        rating: 4.2,
        reviewCount: 67,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  static List<CommunityPostModel> getMockPosts() {
    return [
      CommunityPostModel(
        id: '1',
        userId: 'user1',
        user: UserPostInfo(
          id: 'user1',
          firstName: 'Ahmed',
          lastName: 'Ali',
        ),
        content: 'Just returned from an amazing trip to Hunza! The views were absolutely breathtaking. Highly recommend visiting during spring! 🌸',
        images: [],
        location: null,
        likesCount: 24,
        commentsCount: 5,
        isLiked: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      CommunityPostModel(
        id: '2',
        userId: 'user2',
        user: UserPostInfo(
          id: 'user2',
          firstName: 'Sara',
          lastName: 'Khan',
        ),
        content: 'Looking for travel buddies for a trip to Skardu next month. Anyone interested?',
        images: [],
        location: null,
        likesCount: 12,
        commentsCount: 8,
        isLiked: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      CommunityPostModel(
        id: '3',
        userId: 'user3',
        user: UserPostInfo(
          id: 'user3',
          firstName: 'Hassan',
          lastName: 'Raza',
        ),
        content: 'Best places to visit in Lahore for a day trip?',
        images: [],
        location: null,
        likesCount: 8,
        commentsCount: 15,
        isLiked: false,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}

