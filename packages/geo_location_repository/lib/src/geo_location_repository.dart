import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:geolocator_api/geolocator_api.dart' as geolocator_api;

enum LocationPermissionStatus {
  locationServicesDisabled,
  locationPermissionDenied,
  locationPermanentlyDenied,
  locationPermissionGranted,
  unknown,
}

/// Simple repository for accessing GeolocatorAPI to get the user's location,
/// requesting location permissions, and for opening the settings in-app
/// settings screen.
class GeoLocationRepository {
  const GeoLocationRepository(
      {this.geolocatorApiClient = const geolocator_api.GeolocatorApiClient()});

  final geolocator_api.GeolocatorApiClient geolocatorApiClient;

  Future<UserLocation> getUserLocation() async {
    final geolocator_api.UserLocation userLocation =
        await geolocatorApiClient.getUserLocation();

    return UserLocation(
      latitude: userLocation.latitude,
      longitude: userLocation.longitude,
    );
  }

  Future<LocationPermissionStatus> requestLocationPermission() async {
    final geolocator_api.LocationPermissionStatus locationPermissionStatus =
        await geolocatorApiClient.requestLocationPermission();

    return locationPermissionStatus.toStatus;
  }

  Future<bool> openLocationSettings() async {
    return await geolocatorApiClient.openLocationSettings();
  }

  Future<bool> openAppSettings() async {
    return await geolocatorApiClient.openAppSettings();
  }
}

extension on geolocator_api.LocationPermissionStatus {
  LocationPermissionStatus get toStatus {
    switch (this) {
      case geolocator_api.LocationPermissionStatus.locationServicesDisabled:
        return LocationPermissionStatus.locationServicesDisabled;
      case geolocator_api.LocationPermissionStatus.locationPermissionDenied:
        return LocationPermissionStatus.locationPermissionDenied;
      case geolocator_api.LocationPermissionStatus.locationPermanentlyDenied:
        return LocationPermissionStatus.locationPermanentlyDenied;
      case geolocator_api.LocationPermissionStatus.locationPermissionGranted:
        return LocationPermissionStatus.locationPermissionGranted;
      default:
        return LocationPermissionStatus.unknown;
    }
  }
}
