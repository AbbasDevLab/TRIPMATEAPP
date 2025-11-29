import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PartnerPortalPage extends ConsumerStatefulWidget {
  const PartnerPortalPage({super.key});

  @override
  ConsumerState<PartnerPortalPage> createState() => _PartnerPortalPageState();
}

class _PartnerPortalPageState extends ConsumerState<PartnerPortalPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partner Portal'),
      ),
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Register as Guide'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.drive_eta_outlined),
                selectedIcon: Icon(Icons.drive_eta),
                label: Text('Register as Driver'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.tour_outlined),
                selectedIcon: Icon(Icons.tour),
                label: Text('My Tours'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book_outlined),
                selectedIcon: Icon(Icons.book),
                label: Text('Bookings'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_money_outlined),
                selectedIcon: Icon(Icons.attach_money),
                label: Text('Earnings'),
              ),
            ],
          ),
          // Content
          Expanded(
            child: _getContent(),
          ),
        ],
      ),
    );
  }

  Widget _getContent() {
    switch (_selectedIndex) {
      case 0:
        return const _DashboardTab();
      case 1:
        return const _GuideRegistrationTab();
      case 2:
        return const _DriverRegistrationTab();
      case 3:
        return const _MyToursTab();
      case 4:
        return const _BookingsTab();
      case 5:
        return const _EarningsTab();
      default:
        return const _DashboardTab();
    }
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Partner Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 24.h),
          // Stats cards
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Tours',
                  value: '0',
                  icon: Icons.tour,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _StatCard(
                  title: 'Active Bookings',
                  value: '0',
                  icon: Icons.book,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _StatCard(
                  title: 'Total Earnings',
                  value: 'PKR 0',
                  icon: Icons.attach_money,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Create new tour
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Tour'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: View bookings
                },
                icon: const Icon(Icons.book),
                label: const Text('View Bookings'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: View earnings
                },
                icon: const Icon(Icons.analytics),
                label: const Text('View Analytics'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32.w),
            SizedBox(height: 12.h),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideRegistrationTab extends StatelessWidget {
  const _GuideRegistrationTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register as Guide',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          const Text('Guide registration form coming soon...'),
        ],
      ),
    );
  }
}

class _DriverRegistrationTab extends StatelessWidget {
  const _DriverRegistrationTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register as Driver',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          const Text('Driver registration form coming soon...'),
        ],
      ),
    );
  }
}

class _MyToursTab extends StatelessWidget {
  const _MyToursTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Tours',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Create new tour
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Tour'),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Center(
            child: Text('No tours created yet'),
          ),
        ],
      ),
    );
  }
}

class _BookingsTab extends StatelessWidget {
  const _BookingsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bookings',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          const Center(
            child: Text('No bookings yet'),
          ),
        ],
      ),
    );
  }
}

class _EarningsTab extends StatelessWidget {
  const _EarningsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          const Center(
            child: Text('Earnings dashboard coming soon...'),
          ),
        ],
      ),
    );
  }
}

