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
      appBar: _currentIndex == 0
          ? AppBar(
              title: const Text('Trip Mate'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () => context.push('/chat'),
                ),
              ],
            )
          : null,
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
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Ready to plan your next adventure?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
            ),
            SizedBox(height: 24.h),
            // Quick actions
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.add_circle_outline,
                    title: 'Plan Trip',
                    color: Colors.blue,
                    onTap: () => context.push('/trips/create'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.search,
                    title: 'Find Tours',
                    color: Colors.green,
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
                    title: 'AI Assistant',
                    color: Colors.purple,
                    onTap: () => context.push('/ai-assistant'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.people_outline,
                    title: 'Community',
                    color: Colors.orange,
                    onTap: () => context.push('/community'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            // Upcoming trips section
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
          ],
        ),
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
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Icon(icon, size: 32.w, color: color),
              SizedBox(height: 8.h),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
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

