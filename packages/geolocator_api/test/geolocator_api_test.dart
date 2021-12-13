import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:geolocator_api/geolocator_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGeolocatorWrapper extends Mock implements GeolocatorWrapper {}

class MockPosition extends Mock implements Position {}

void main() {
  late GeolocatorApiClient geolocatorApiClient;
  late MockGeolocatorWrapper mockGeolocatorWrapper = MockGeolocatorWrapper();

  setUp(() {
    geolocatorApiClient =
        GeolocatorApiClient(geolocator: mockGeolocatorWrapper);
  });

  group('GeolocatorApiClient', () {
    test('Verify initialized successfully.', () {
      expect(
        const GeolocatorApiClient(),
        isNotNull,
      );
    });

    test('Successfully get current location', () async {
      const UserLocation userLocation = UserLocation(
        latitude: 36.167839,
        longitude: -86.778160,
      );

      MockPosition mockPosition = MockPosition();

      when(() => mockPosition.latitude).thenReturn(36.167839);
      when(() => mockPosition.longitude).thenReturn(-86.778160);

      when(() => mockGeolocatorWrapper.getCurrentPosition())
          .thenAnswer((invocation) async => mockPosition);

      expect(
        await geolocatorApiClient.getUserLocation(),
        userLocation,
      );
    });

    test('Geolocator getCurrentPosition failure', () async {
      when(() => mockGeolocatorWrapper.getCurrentPosition())
          .thenAnswer((_) async => throw TimeoutException('timeout'));

      expect(
        () => geolocatorApiClient.getUserLocation(),
        throwsA(
          isA<CurrentPositionException>(),
        ),
      );
    });

    test('Geolocator has Location Services enabled', () async {
      when(() => mockGeolocatorWrapper.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(() => mockGeolocatorWrapper.requestPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(() => mockGeolocatorWrapper.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);

      expect(
        await geolocatorApiClient.requestLocationPermission(),
        LocationPermissionStatus.locationPermissionGranted,
      );
    });

    test('Geolocator - Location Services disabled', () async {
      when(() => mockGeolocatorWrapper.isLocationServiceEnabled())
          .thenAnswer((_) async => false);
      when(() => mockGeolocatorWrapper.requestPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(() => mockGeolocatorWrapper.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);

      expect(
        await geolocatorApiClient.requestLocationPermission(),
        LocationPermissionStatus.locationServicesDisabled,
      );
    });

    test('Geolocator - Location Permission Denied', () async {
      when(() => mockGeolocatorWrapper.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(() => mockGeolocatorWrapper.requestPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(() => mockGeolocatorWrapper.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      expect(
        await geolocatorApiClient.requestLocationPermission(),
        LocationPermissionStatus.locationPermissionDenied,
      );
    });

    test('Geolocator - Location Permission Denied Forever', () async {
      when(() => mockGeolocatorWrapper.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(() => mockGeolocatorWrapper.requestPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(() => mockGeolocatorWrapper.checkPermission())
          .thenAnswer((_) async => LocationPermission.deniedForever);

      expect(
        await geolocatorApiClient.requestLocationPermission(),
        LocationPermissionStatus.locationPermanentlyDenied,
      );
    });

    test('Open location settings', () async {
      when(() => mockGeolocatorWrapper.openLocationSettings())
          .thenAnswer((_) async => true);

      expect(
        await geolocatorApiClient.openLocationSettings(),
        true,
      );
    });

    test('Open app settings', () async {
      when(() => mockGeolocatorWrapper.openAppSettings()).thenAnswer(
        (_) async => true,
      );

      expect(
        await geolocatorApiClient.openAppSettings(),
        true,
      );
    });
  });
}
