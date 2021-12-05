import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  group('Weather', () {
    test('Check if two Weather objects are equal.', () {
      Weather weather = Weather(
        12345,
        'Light Rain',
        'https://www.metaweather.com/static/img/weather/png/64/lr.png',
        44.0,
        80.0,
        76.0,
        DateTime(2021, 12, 5),
      );

      Weather weather2 = Weather(
        12345,
        'Light Rain',
        'https://www.metaweather.com/static/img/weather/png/64/lr.png',
        44.0,
        80.0,
        76.0,
        DateTime(2021, 12, 5),
      );

      expect(weather, weather2);
    });
  });
}
