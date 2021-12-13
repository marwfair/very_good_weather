import 'package:geolocator_api/geolocator_api.dart';
import 'package:test/test.dart';

void main() {
  group('UserLocation', () {
    test('Create UserLocation', () {
      expect(
          const UserLocation(
            latitude: 36.167839,
            longitude: -86.778160,
          ),
          isA<UserLocation>());
    });
  });
}
