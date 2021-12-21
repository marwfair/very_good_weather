import 'package:meta_weather_api/meta_weather_api.dart' as meta_weather_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

class MockMetaWeatherApiClient extends Mock
    implements meta_weather_api.MetaWeatherApiClient {}

class MockLocation extends Mock implements meta_weather_api.Location {}

class MockWeather extends Mock implements meta_weather_api.Weather {}

void main() {
  late meta_weather_api.MetaWeatherApiClient mockMetaWeatherApiClient;
  late WeatherRepository weatherRepository;

  group('WeatherRepository', () {
    setUp(() {
      mockMetaWeatherApiClient = MockMetaWeatherApiClient();
      weatherRepository =
          WeatherRepository(metaWeatherApiClient: mockMetaWeatherApiClient);
    });

    test('Verify initialized successfully.', () {
      expect(WeatherRepository(metaWeatherApiClient: mockMetaWeatherApiClient),
          isNotNull);
    });

    test('Verify initialized successfully with default client.', () {
      expect(WeatherRepository(), isNotNull);
    });

    test('Call locationSearch.', () async {
      const String city = 'nashville';
      try {
        await weatherRepository.getWeatherFromQuery(city);
      } catch (_) {}

      verify(() => mockMetaWeatherApiClient.locationSearch(city)).called(1);
    });

    test('Call latLngSearch.', () async {
      try {
        await weatherRepository.getWeatherFromLocation(36.167839, -86.778160);
      } catch (_) {}

      verify(() => mockMetaWeatherApiClient.latLngSearch(36.167839, -86.778160))
          .called(1);
    });

    test('Get weather from query.', () async {
      final MockWeather weather = MockWeather();

      when(() => weather.id).thenReturn(12345);
      when(() => weather.theTemp).thenReturn(76.0);
      when(() => weather.minTemp).thenReturn(44.0);
      when(() => weather.maxTemp).thenReturn(80.0);
      when(() => weather.weatherState)
          .thenReturn(meta_weather_api.WeatherState.clear);
      when(() => weather.applicableDate).thenReturn(DateTime(2021, 12, 5));

      when(() => mockMetaWeatherApiClient.locationSearch('nashville'))
          .thenAnswer((invocation) async => <meta_weather_api.Location>[
                const meta_weather_api.Location(
                    title: 'Nashville',
                    locationType: 'City',
                    woeid: 2457170,
                    latLng: meta_weather_api.LatLng(
                        latitude: 36.167839, longitude: -86.778160))
              ]);

      when(() => mockMetaWeatherApiClient.getWeather(2457170)).thenAnswer(
          (invocation) async => <meta_weather_api.Weather>[weather]);

      final List<Weather> weatherList =
          await weatherRepository.getWeatherFromQuery('nashville');

      expect(
        weatherList,
        isA<List<Weather>>().having(
          (weathers) => weathers[0].id,
          'id',
          12345,
        ),
      );
    });

    test('Get weather from location.', () async {
      final MockWeather weather = MockWeather();

      when(() => weather.id).thenReturn(12345);
      when(() => weather.theTemp).thenReturn(76.0);
      when(() => weather.minTemp).thenReturn(44.0);
      when(() => weather.maxTemp).thenReturn(80.0);
      when(() => weather.weatherState)
          .thenReturn(meta_weather_api.WeatherState.showers);
      when(() => weather.applicableDate).thenReturn(DateTime(2021, 12, 5));

      when(() => mockMetaWeatherApiClient.latLngSearch(36.167839, -86.778160))
          .thenAnswer((invocation) async => <meta_weather_api.Location>[
                const meta_weather_api.Location(
                    title: 'Nashville',
                    locationType: 'City',
                    woeid: 2457170,
                    latLng: meta_weather_api.LatLng(
                        latitude: 36.167839, longitude: -86.778160))
              ]);

      when(() => mockMetaWeatherApiClient.getWeather(2457170)).thenAnswer(
          (invocation) async => <meta_weather_api.Weather>[weather]);

      final List<Weather> weatherList =
          await weatherRepository.getWeatherFromLocation(36.167839, -86.778160);

      expect(
        weatherList,
        isA<List<Weather>>().having(
          (weathers) => weathers[0].id,
          'id',
          12345,
        ),
      );
    });
  });
}
