import 'package:meta_weather_api/meta_weather_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('Checks if Location has the same title.', () {
        expect(
          Location.fromJson(const <String, dynamic>{
            'title': 'Nashville',
            'location_type': 'City',
            'latt_long': '36.167839,-86.778160',
            'woeid': 2457170
          }),
          isA<Location>().having(
            (location) => location.title,
            'title',
            'Nashville',
          ),
        );
      });

      test('Checks if Locations have the same coordinates.', () {
        expect(
          Location.fromJson(const <String, dynamic>{
            'title': 'Nashville',
            'location_type': 'City',
            'latt_long': '36.167839,-86.778160',
            'woeid': 2457170
          }),
          isA<Location>().having(
            (location) => location.latLng,
            'latt_long',
            const LatLng(
              latitude: 36.167839,
              longitude: -86.778160,
            ),
          ),
        );
      });

      test('Checks if Locations are the same.', () {
        final Location location1 = Location.fromJson(const <String, dynamic>{
          'title': 'Nashville',
          'location_type': 'City',
          'latt_long': '36.167839,-86.778160',
          'woeid': 2457170
        });

        final Location location2 = Location.fromJson(const <String, dynamic>{
          'title': 'Nashville',
          'location_type': 'City',
          'latt_long': '36.167839,-86.778160',
          'woeid': 2457170
        });

        expect(location1, location2);
      });

      test('Create json from LatLng', () {
        final LatLng latLng =
            LatLng(latitude: 36.167839, longitude: -86.778160);
        expect(LatLngConverter().toJson(latLng), '36.167839,-86.77816');
      });
    });
  });
}
