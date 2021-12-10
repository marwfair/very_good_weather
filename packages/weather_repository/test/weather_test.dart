import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  group('Weather', () {
    test('Check if two Weather objects are equal.', () {
      Weather weather = Weather(
        12345,
        WeatherCondition.lightRain,
        44.0,
        80.0,
        76.0,
        DateTime(2021, 12, 5),
        'Nashville',
        12345,
      );

      Weather weather2 = Weather(
        12345,
        WeatherCondition.lightRain,
        44.0,
        80.0,
        76.0,
        DateTime(2021, 12, 5),
        'Nashville',
        12345,
      );

      expect(weather, weather2);
    });
  });
}
