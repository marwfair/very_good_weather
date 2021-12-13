import 'package:geolocator/geolocator.dart';
import 'package:geolocator_api/geolocator_api.dart';

/// Exception thrown when unable to get user's location.
class CurrentPositionException implements Exception {}

/// Exception thrown when Location Services are disabled.
class LocationServicesDisabledException implements Exception {}

/// Exception thrown when Location Permission is denied.
class LocationPermissionDeniedException implements Exception {}

/// Exception thrown when Location Permission is permanently denied.
class LocationPermissionPermanentlyDeniedException implements Exception {}

enum LocationPermissionStatus {
  locationServicesDisabled,
  locationPermissionDenied,
  locationPermanentlyDenied,
  locationPermissionGranted,
}

class GeolocatorApiClient {
  const GeolocatorApiClient({this.geolocator = const GeolocatorWrapper()});

  final GeolocatorWrapper geolocator;

  Future<UserLocation> getUserLocation() async {
    try {
      final Position position = await geolocator.getCurrentPosition();
      return UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw CurrentPositionException();
    }
  }

  Future<LocationPermissionStatus> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationPermissionStatus.locationServicesDisabled;
    }

    permission = await geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationPermissionStatus.locationPermissionDenied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionStatus.locationPermanentlyDenied;
    }

    return LocationPermissionStatus.locationPermissionGranted;
  }

  Future<bool> openLocationSettings() async {
    return await geolocator.openLocationSettings();
  }

  Future<bool> openAppSettings() async {
    return await geolocator.openAppSettings();
  }
}
