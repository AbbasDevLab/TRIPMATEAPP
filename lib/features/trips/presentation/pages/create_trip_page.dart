import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/models/trip_model.dart';

class CreateTripPage extends ConsumerStatefulWidget {
  const CreateTripPage({super.key});

  @override
  ConsumerState<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends ConsumerState<CreateTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _destinationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();

  TripCategory _selectedCategory = TripCategory.leisure;
  TripType _selectedType = TripType.solo;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  Future<void> _createTrip() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select travel dates')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Call API to create trip
      // For now, just show success
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip created successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create trip: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Trip'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _createTrip,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Trip Title',
                  hintText: 'e.g., Summer Vacation to Northern Areas',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a trip title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              // Destination
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  hintText: 'e.g., Hunza Valley, Pakistan',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              // Date Range
              InkWell(
                onTap: _selectDateRange,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Travel Dates',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _startDate != null && _endDate != null
                        ? '${DateFormat('MMM dd, yyyy').format(_startDate!)} - ${DateFormat('MMM dd, yyyy').format(_endDate!)}'
                        : 'Select dates',
                    style: TextStyle(
                      color: _startDate != null
                          ? null
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Category
              DropdownButtonFormField<TripCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category),
                ),
                items: TripCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(_getCategoryName(category)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                  }
                },
              ),
              SizedBox(height: 16.h),
              // Type
              DropdownButtonFormField<TripType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Trip Type',
                  prefixIcon: Icon(Icons.people),
                ),
                items: TripType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getTypeName(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              SizedBox(height: 16.h),
              // Budget
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Budget (PKR)',
                  hintText: 'Optional',
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              SizedBox(height: 16.h),
              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Tell us about your trip...',
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 24.h),
              // AI Generate Button
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Navigate to AI itinerary generation
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Itinerary with AI'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryName(TripCategory category) {
    switch (category) {
      case TripCategory.adventure:
        return 'Adventure';
      case TripCategory.cultural:
        return 'Cultural';
      case TripCategory.religious:
        return 'Religious';
      case TripCategory.educational:
        return 'Educational';
      case TripCategory.leisure:
        return 'Leisure';
      case TripCategory.business:
        return 'Business';
      case TripCategory.photography:
        return 'Photography';
      case TripCategory.foodDining:
        return 'Food & Dining';
    }
  }

  String _getTypeName(TripType type) {
    switch (type) {
      case TripType.solo:
        return 'Solo';
      case TripType.group:
        return 'Group';
      case TripType.family:
        return 'Family';
      case TripType.business:
        return 'Business';
      case TripType.educational:
        return 'Educational';
      case TripType.religious:
        return 'Religious';
    }
  }
}

