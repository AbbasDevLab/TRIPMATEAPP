import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'type': 'like',
      'userName': 'Sarah Khan',
      'userAvatar': Icons.person,
      'message': 'liked your post',
      'time': '5 minutes ago',
      'isRead': false,
    },
    {
      'id': '2',
      'type': 'comment',
      'userName': 'Ahmed Ali',
      'userAvatar': Icons.person,
      'message': 'commented on your post',
      'comment': 'This looks amazing! Would love to join next time.',
      'time': '1 hour ago',
      'isRead': false,
    },
    {
      'id': '3',
      'type': 'join',
      'userName': 'Fatima Hassan',
      'userAvatar': Icons.person,
      'message': 'joined your group tour to Hunza Valley',
      'time': '2 hours ago',
      'isRead': false,
    },
    {
      'id': '4',
      'type': 'tour',
      'title': 'TripMate',
      'icon': Icons.explore,
      'message': 'New group tour available',
      'details': 'Beach Paradise to Maldives - Only 8 spots left!',
      'time': '3 hours ago',
      'isRead': true,
    },
    {
      'id': '5',
      'type': 'like',
      'userName': 'Usman Sheikh',
      'userAvatar': Icons.person,
      'message': 'liked your comment',
      'time': '5 hours ago',
      'isRead': true,
    },
  ];

  int get unreadCount => _notifications.where((n) => !n['isRead']).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue gradient header (matching Figma)
          Container(
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
              bottom: 16.h,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (unreadCount > 0)
                        Text(
                          '$unreadCount new',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                        ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      for (var notification in _notifications) {
                        notification['isRead'] = true;
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All notifications marked as read')),
                    );
                  },
                  child: const Text(
                    'Mark all read',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Notifications list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _NotificationCard(
                  notification: notification,
                  onTap: () {
                    setState(() {
                      notification['isRead'] = true;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification['isRead'] as bool;
    final type = notification['type'] as String;

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar/Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getColorForType(type).withOpacity(0.1),
                ),
                child: Icon(
                  notification['userAvatar'] ?? notification['icon'] ?? Icons.notifications,
                  color: _getColorForType(type),
                ),
              ),
              SizedBox(width: 12.w),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: notification['userName'] ?? notification['title'] ?? 'TripMate',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' ${notification['message']}',
                          ),
                        ],
                      ),
                    ),
                    if (notification['comment'] != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        notification['comment'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                    if (notification['details'] != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        notification['details'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                    SizedBox(height: 4.h),
                    Text(
                      notification['time'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              // Unread indicator
              if (!isRead)
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'like':
        return Colors.red;
      case 'comment':
        return Colors.blue;
      case 'join':
        return Colors.green;
      case 'tour':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

