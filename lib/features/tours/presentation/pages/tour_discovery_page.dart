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
      body: Column(
        children: [
          // Blue gradient header with search (matching Figma)
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Group Tours',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 12.h),
                // Search bar with filter icon (matching Figma)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search destinations...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: () {
                        // TODO: Show filter dialog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Filter chips (matching Figma)
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: SizedBox(
              height: 40.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'all',
                    onTap: () => setState(() => _selectedFilter = 'all'),
                  ),
                  SizedBox(width: 8.w),
                  _FilterChip(
                    label: 'Beach',
                    isSelected: _selectedFilter == 'beach',
                    onTap: () => setState(() => _selectedFilter = 'beach'),
                  ),
                  SizedBox(width: 8.w),
                  _FilterChip(
                    label: 'Mountain',
                    isSelected: _selectedFilter == 'mountain',
                    onTap: () => setState(() => _selectedFilter = 'mountain'),
                  ),
                  SizedBox(width: 8.w),
                  _FilterChip(
                    label: 'City',
                    isSelected: _selectedFilter == 'city',
                    onTap: () => setState(() => _selectedFilter = 'city'),
                  ),
                  SizedBox(width: 8.w),
                  _FilterChip(
                    label: 'Adventure',
                    isSelected: _selectedFilter == 'adventure',
                    onTap: () => setState(() => _selectedFilter = 'adventure'),
                  ),
                ],
              ),
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Text(
                              '${filteredTours.length} tours available',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: filteredTours.length,
                              itemBuilder: (context, index) {
                                final tour = filteredTours[index];
                                return _TourCard(tour: tour);
                              },
                            ),
                          ),
                        ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to tour details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tags (matching Figma)
            Stack(
              children: [
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
                // Featured tag (matching Figma)
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Featured',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Save tag (matching Figma)
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Save \$300',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
                  // Date and Available spots (matching Figma)
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${_formatDate(tour.startDate)} - ${_formatDate(tour.endDate)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 16.w),
                      Icon(Icons.people, size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        'Available',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '8 spots',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Pricing (matching Figma)
                  Row(
                    children: [
                      Text(
                        '\$${tour.price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '\$${(tour.price * 1.3).toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey.shade600,
                            ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '/ person',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to tour details
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('View Details'),
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

