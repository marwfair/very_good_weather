import 'package:geolocator/geolocator.dart';

/// Simple wrapper for Geolocator to make it easier to mock.
class GeolocatorWrapper {
  const GeolocatorWrapper();

  Future<Position> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLocationServiceEnabled() async =>
      await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> checkPermission() async =>
      await Geolocator.checkPermission();

  Future<LocationPermission> requestPermission() async {
    try {
      return await Geolocator.requestPermission();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> openLocationSettings() async =>
      await Geolocator.openLocationSettings();

  Future<bool> openAppSettings() async => await Geolocator.openAppSettings();
}
