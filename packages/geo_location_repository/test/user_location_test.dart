import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:test/test.dart';

void main() {
  group('UserLocation', () {
    test('Objects are equal', () {
      const userLocation = UserLocation(
        latitude: 36.167839,
        longitude: -86.778160,
      );

      expect(
        userLocation,
        const UserLocation(latitude: 36.167839, longitude: -86.778160),
      );
    });
  });
}
