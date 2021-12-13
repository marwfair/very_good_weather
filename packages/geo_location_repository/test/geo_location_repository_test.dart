import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:geolocator_api/geolocator_api.dart' as geolocator_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGeolocatorApiClient extends Mock
    implements geolocator_api.GeolocatorApiClient {}

class MockUserLocation extends Mock implements geolocator_api.UserLocation {}

void main() {
  late MockGeolocatorApiClient mockGeolocatorApiClient;

  group('GeoLocationRepository', () {
    setUp(() {
      mockGeolocatorApiClient = MockGeolocatorApiClient();
    });

    test('Verify initialized successfully', () {
      expect(
          GeoLocationRepository(geolocatorApiClient: mockGeolocatorApiClient),
          isNotNull);
    });
  });
}
