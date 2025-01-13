import 'dart:async';
import 'package:deliver_partner/services/API_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  final ApiServices _apiServices = GetIt.I<ApiServices>();
  Timer? _timer;
  SharedPreferences? _sharedPreferences;

  int _userID = -1;
  bool _isUpdatingLocation = false;

  /// Initialize the service
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _userID = _sharedPreferences?.getInt('userID') ?? -1;
    _startLocationUpdates();
  }

  /// Start the periodic location updates
  void _startLocationUpdates() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await _updateLocation();
    });
  }

  /// Stop the periodic location updates
  void stopLocationUpdates() {
    _timer?.cancel();
  }

  /// Update location
  Future<void> _updateLocation() async {
    if (_isUpdatingLocation) return;

    _isUpdatingLocation = true;

    bool hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      _isUpdatingLocation = false;
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      Map<String, String> updateLocationData = {
        "users_fleet_id": _userID.toString(),
        "latitude": position.latitude.toString(),
        "longitude": position.longitude.toString(),
      };

      var response = await _apiServices.updateLocationOneTimeAPI(updateLocationData);

      if (response.status?.toLowerCase() == 'success') {
        debugPrint('Location updated successfully: $updateLocationData');
      } else {
        debugPrint('Failed to update location: ${response.message}');
      }
    } catch (e) {
      debugPrint('Error updating location: $e');
    }

    _isUpdatingLocation = false;
  }

  /// Handle location permission
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      return false;
    }

    return true;
  }
}
