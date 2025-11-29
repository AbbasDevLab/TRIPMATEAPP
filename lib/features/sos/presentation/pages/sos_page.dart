import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/location_service.dart';

class SOSPage extends ConsumerStatefulWidget {
  const SOSPage({super.key});

  @override
  ConsumerState<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends ConsumerState<SOSPage> {
  final LocationService _locationService = LocationService();
  bool _isSending = false;
  String? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      final address = await _locationService.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _currentLocation = address;
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Location unavailable';
      });
    }
  }

  Future<void> _sendSOS() async {
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      useRootNavigator: true,
      builder: (context) => AlertDialog(
        title: const Text('Send SOS Emergency?'),
        content: const Text(
          'This will send your location to emergency contacts and authorities. Are you sure you want to proceed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Send SOS'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isSending = true);

    try {
      // TODO: Send SOS via API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black54,
          useRootNavigator: true,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('SOS Sent'),
              ],
            ),
            content: const Text(
              'Your emergency alert has been sent. Help is on the way!',
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send SOS: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Emergency'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SOS Icon
              Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emergency,
                  size: 100.w,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Emergency SOS',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Press the button below to send an emergency alert with your location to emergency contacts and authorities.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 32.h),
              // Location info
              if (_currentLocation != null)
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            _currentLocation!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 32.h),
              // SOS Button
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: _isSending ? null : _sendSOS,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSending
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.emergency, size: 32),
                            SizedBox(width: 12.w),
                            Text(
                              'SEND SOS',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 24.h),
              // Emergency contacts
              TextButton(
                onPressed: () {
                  // TODO: Navigate to emergency contacts
                },
                child: const Text('Manage Emergency Contacts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

