import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/models/tour_model.dart';
import '../../../../core/providers/tour_provider.dart';

class TourDiscoveryPage extends ConsumerStatefulWidget {
  const TourDiscoveryPage({super.key});

  @override
  ConsumerState<TourDiscoveryPage> createState() => _TourDiscoveryPageState();
}

class _TourDiscoveryPageState extends ConsumerState<TourDiscoveryPage> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toursAsync = ref.watch(tourListProvider);
    final searchQuery = _searchController.text.toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Tours'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tours...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // Filter chips
          SizedBox(
            height: 50.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: _selectedFilter == 'all',
                  onTap: () => setState(() => _selectedFilter = 'all'),
                ),
                SizedBox(width: 8.w),
                _FilterChip(
                  label: 'Available',
                  isSelected: _selectedFilter == 'available',
                  onTap: () => setState(() => _selectedFilter = 'available'),
                ),
                SizedBox(width: 8.w),
                _FilterChip(
                  label: 'Upcoming',
                  isSelected: _selectedFilter == 'upcoming',
                  onTap: () => setState(() => _selectedFilter = 'upcoming'),
                ),
                SizedBox(width: 8.w),
                _FilterChip(
                  label: 'Popular',
                  isSelected: _selectedFilter == 'popular',
                  onTap: () => setState(() => _selectedFilter = 'popular'),
                ),
              ],
            ),
          ),
          // Tours list
          Expanded(
            child: toursAsync.when(
              data: (tours) {
                // Filter tours based on search and filter
                var filteredTours = tours;
                
                if (searchQuery.isNotEmpty) {
                  filteredTours = tours.where((tour) {
                    return tour.title.toLowerCase().contains(searchQuery) ||
                        tour.destination.toLowerCase().contains(searchQuery);
                  }).toList();
                }

                if (_selectedFilter == 'available') {
                  filteredTours = filteredTours.where((t) => t.isAvailable).toList();
                } else if (_selectedFilter == 'upcoming') {
                  filteredTours = filteredTours.where((t) => t.startDate.isAfter(DateTime.now())).toList();
                } else if (_selectedFilter == 'popular') {
                  filteredTours = filteredTours.where((t) => t.rating != null && t.rating! >= 4.0).toList();
                }

                return filteredTours.isEmpty
                    ? EmptyStateWidget(
                        title: 'No Tours Found',
                        message: 'Try adjusting your search or filters',
                        icon: Icons.explore_outlined,
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: filteredTours.length,
                        itemBuilder: (context, index) {
                          final tour = filteredTours[index];
                          return _TourCard(tour: tour);
                        },
                      );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error loading tours: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(tourListProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}

class _TourCard extends StatelessWidget {
  final TourModel tour;

  const _TourCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to tour details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (tour.images.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  tour.images.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 64),
                    );
                  },
                ),
              )
            else
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 64),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tour.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        tour.destination,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        '${_formatDate(tour.startDate)} - ${_formatDate(tour.endDate)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      if (tour.rating != null) ...[
                        Icon(Icons.star, size: 16.w, color: Colors.amber),
                        SizedBox(width: 4.w),
                        Text(
                          tour.rating!.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '(${tour.reviewCount} reviews)',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const Spacer(),
                      ],
                      Text(
                        'PKR ${tour.price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Navigate to tour details
                          },
                          child: const Text('View Details'),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: tour.isAvailable
                              ? () {
                                  // TODO: Book tour
                                }
                              : null,
                          child: const Text('Book Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

