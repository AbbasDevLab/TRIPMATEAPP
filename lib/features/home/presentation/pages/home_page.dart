import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../trips/presentation/pages/trip_list_page.dart';
import '../../../tours/presentation/pages/tour_discovery_page.dart';
import '../../../community/presentation/pages/community_feed_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../../core/providers/trip_provider.dart';
import '../../../../core/providers/tour_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _HomeTab(),
          _TripsTab(),
          _ToursTab(),
          _CommunityTab(),
          _ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore_outlined),
            activeIcon: Icon(Icons.travel_explore),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            label: 'Tours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Blue gradient header (matching Figma)
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ],
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16.h,
              left: 16.w,
              right: 16.w,
              bottom: 24.h,
            ),
            child: Column(
              children: [
                // Header row with avatar, logo, and icons
                Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 20.w,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(width: 12.w),
                    // TripMate logo text
                    Text(
                      'TripMate',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    // Notification icon
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                      onPressed: () {},
                    ),
                    // Chat icon
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                      onPressed: () => context.push('/chat'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Welcome card (matching Figma)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, Haider!',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Ready for your next adventure?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Main content
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Quick Actions section (matching Figma)
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16.h),
              // Quick action buttons in 2x2 grid
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.add_circle_outline,
                      title: 'Plan Trip',
                      color: Colors.green,
                      onTap: () => context.push('/trips/create'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.search,
                      title: 'Find Tour',
                      color: Colors.orange,
                      onTap: () => context.push('/tours'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.chat_bubble_outline,
                      title: 'Chat',
                      color: Colors.purple,
                      onTap: () => context.push('/chat'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.warning_amber_rounded,
                      title: 'SOS',
                      color: Colors.red,
                      onTap: () => context.push('/sos'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              // AI Travel Assistant card (matching Figma)
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'AI Travel Assistant',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Ask me anything about your travel plans, destinations, or get personalized recommendations!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/ai-assistant'),
                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                      label: const Text('Start Chat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              // Group Tours section (matching Figma)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Group Tours',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () => context.push('/tours'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Tours from provider
              Consumer(
                builder: (context, ref, child) {
                  final toursAsync = ref.watch(tourListProvider);
                  return toursAsync.when(
                    data: (tours) {
                      if (tours.isEmpty) {
                        return Center(
                          child: Text(
                            'No tours available',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tours.take(5).length,
                          itemBuilder: (context, index) {
                            final tour = tours[index];
                            return Container(
                              width: 200.w,
                              margin: EdgeInsets.only(right: 12.w),
                              child: Card(
                                child: Row(
                                  children: [
                                    // Tour image placeholder
                                    Container(
                                      width: 80.w,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                      ),
                                      child: Icon(Icons.image, color: Colors.grey.shade600),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              tour.title,
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on, size: 14.w, color: Colors.grey),
                                                SizedBox(width: 4.w),
                                                Expanded(
                                                  child: Text(
                                                    tour.destination,
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const SizedBox.shrink(),
                  );
                },
              ),
              SizedBox(height: 32.h),
              // Upcoming trips section (keeping existing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Trips',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: () => context.push('/trips'),
                  child: const Text('View All'),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Trips from provider
            Consumer(
              builder: (context, ref, child) {
                final tripsAsync = ref.watch(tripListProvider);
                return tripsAsync.when(
                  data: (trips) {
                    final upcomingTrips = trips
                        .where((t) => t.startDate.isAfter(DateTime.now()))
                        .take(3)
                        .toList();
                    if (upcomingTrips.isEmpty) {
                      return Center(
                        child: Text(
                          'No upcoming trips',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: upcomingTrips.length,
                        itemBuilder: (context, index) {
                          final trip = upcomingTrips[index];
                          return Container(
                            width: 200.w,
                            margin: EdgeInsets.only(right: 12.w),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trip.title,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      trip.destination,
                                      style: Theme.of(context).textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox.shrink(),
                );
              },
            ),
            SizedBox(height: 32.h),
            // Popular tours section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Tours',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: () => context.push('/tours'),
                  child: const Text('View All'),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Tours from provider
            Consumer(
              builder: (context, ref, child) {
                final toursAsync = ref.watch(tourListProvider);
                return toursAsync.when(
                  data: (tours) {
                    final popularTours = tours
                        .where((t) => t.rating != null && t.rating! >= 4.0)
                        .take(3)
                        .toList();
                    if (popularTours.isEmpty) {
                      return Center(
                        child: Text(
                          'No tours available',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularTours.length,
                        itemBuilder: (context, index) {
                          final tour = popularTours[index];
                          return Container(
                            width: 200.w,
                            margin: EdgeInsets.only(right: 12.w),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tour.title,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        if (tour.rating != null) ...[
                                          Icon(Icons.star, size: 14.w, color: Colors.amber),
                                          SizedBox(width: 4.w),
                                          Text(
                                            tour.rating!.toStringAsFixed(1),
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ],
                                        const Spacer(),
                                        Text(
                                          'PKR ${tour.price.toStringAsFixed(0)}',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox.shrink(),
                );
              },
            ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32.w, color: color),
            SizedBox(height: 8.h),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripsTab extends StatelessWidget {
  const _TripsTab();

  @override
  Widget build(BuildContext context) {
    return const TripListPage();
  }
}

class _ToursTab extends StatelessWidget {
  const _ToursTab();

  @override
  Widget build(BuildContext context) {
    return const TourDiscoveryPage();
  }
}

class _CommunityTab extends StatelessWidget {
  const _CommunityTab();

  @override
  Widget build(BuildContext context) {
    return const CommunityFeedPage();
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

