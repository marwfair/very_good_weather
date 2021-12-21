import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  late Weather nashvilleWeather;

  setUp(() {
    nashvilleWeather = Weather(
      12345,
      WeatherCondition.lightRain,
      44.0,
      80.0,
      76.0,
      DateTime(2021, 12, 5),
      'Nashville',
      12345,
    );
  });

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

      expect(nashvilleWeather, weather);
    });

    test('Create fom json', () {
      Map<String, dynamic> weatherJson = nashvilleWeather.toJson();

      expect(Weather.fromJson(weatherJson), nashvilleWeather);
    });
  });
}
