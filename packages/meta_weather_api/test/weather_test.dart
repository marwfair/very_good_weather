import 'package:meta_weather_api/meta_weather_api.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('Checks if Weather has correct id.', () {
        expect(
          Weather.fromJson(<String, dynamic>{
            'id': 6374036553596928,
            'weather_state_name': 'Light Rain',
            'weather_state_abbr': 'lr',
            'wind_direction_compass': 'NE',
            'created': '2021-12-04T19:26:16.259090Z',
            'applicable_date': "2021-12-04",
            'min_temp': 11.205,
            'max_temp': 15.04,
            'the_temp': 14.68,
            'wind_speed': 4.277365089403218,
            'wind_direction': 34.52073567458125,
            'air_pressure': 1017.5,
            'humidity': 89,
            'visibility': 9.561038534955857,
            'predictability': 75
          }),
          isA<Weather>().having(
            (weather) => weather.id,
            'id',
            6374036553596928,
          ),
        );
      });
    });
  });
}
