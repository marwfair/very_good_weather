import 'package:http/http.dart' as http;
import 'package:meta_weather_api/src/meta_weather_api_client.dart';
import 'package:meta_weather_api/src/models/models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late MetaWeatherApiClient metaWeatherApiClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockHttpClient();
    metaWeatherApiClient = MetaWeatherApiClient(httpClient: httpClient);
  });

  group('MetaWeatherApi', () {
    test('Verify initialized successfully.', () {
      expect(MetaWeatherApiClient(), isNotNull);
    });

    test('Location request fails.', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(400);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        () async => await metaWeatherApiClient.locationSearch('nashville'),
        throwsA(
          isA<LocationRequestException>(),
        ),
      );
    });

    test('Location request empty.', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('[]');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        () async => await metaWeatherApiClient.locationSearch('nashville'),
        throwsA(
          isA<LocationNotFoundException>(),
        ),
      );
    });

    test('Fetch Locations from search successfully', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('''[
                {
                  "title": "Jacksonville",
                  "location_type": "City",
                  "woeid": 2428344,
                  "latt_long": "30.331381,-81.655800"
                },
                {
                  "title": "Jackson",
                  "location_type": "City",
                  "woeid": 2428184,
                  "latt_long": "32.298691,-90.180489"
                }
              ]''');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        await metaWeatherApiClient.locationSearch('jackson'),
        isA<List<Location>>().having(
          (locations) => locations.length,
          'length',
          2,
        ),
      );
    });

    test('Fetch Locations from coordinates successfully', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('''[
                {
                  "title": "Nashville",
                  "location_type": "City",
                  "woeid": 2457170,
                  "latt_long": "36.167839,-86.778160"
                }
              ]''');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        await metaWeatherApiClient.latLngSearch(36.167839, -86.778160),
        isA<List<Location>>().having(
          (locations) => locations[0].title,
          'title',
          'Nashville',
        ),
      );
    });

    test('Weather request fails.', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(400);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        () async => await metaWeatherApiClient.getWeather(12345),
        throwsA(
          isA<WeatherRequestException>(),
        ),
      );
    });

    test('Weather request empty.', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('''
      {
        "consolidated_weather": [
          {
            "id": 6374036553596928,
            "weather_state_name": "Light Rain",
            "weather_state_abbr": "lr",
            "wind_direction_compass": "NE",
            "created": "2021-12-04T19:26:16.259090Z",
            "applicable_date": "2021-12-04",
            "min_temp": 11.205,
            "max_temp": 15.04,
            "the_temp": 14.68,
            "wind_speed": 4.277365089403218,
            "wind_direction": 34.52073567458125,
            "air_pressure": 1017.5,
            "humidity": 89,
            "visibility": 9.561038534955857,
            "predictability": 75
          },
          {
            "id": 6060282683064320,
            "weather_state_name": "Light Rain",
            "weather_state_abbr": "lr",
            "wind_direction_compass": "S",
            "created": "2021-12-04T19:26:19.174698Z",
            "applicable_date": "2021-12-05",
            "min_temp": 10.695,
            "max_temp": 20.2,
            "the_temp": 17.915,
            "wind_speed": 7.708791423969352,
            "wind_direction": 187.30075995881438,
            "air_pressure": 1015.5,
            "humidity": 85,
            "visibility": 13.852538674143005,
            "predictability": 75
        }
       ]
      }''');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        await metaWeatherApiClient.getWeather(12345),
        isA<List<Weather>>().having(
          (weathers) => weathers.length,
          'length',
          2,
        ),
      );
    });

    test('Weather request empty.', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(
        () async => await metaWeatherApiClient.getWeather(12345),
        throwsA(
          isA<WeatherNotFoundException>(),
        ),
      );
    });

    test('Consolidated Weather array empty.', () async {
      final http.Response response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('''
      {
        "consolidated_weather": []
      }''');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      expect(() async => await metaWeatherApiClient.getWeather(12345),
          throwsA(isA<WeatherNotFoundException>()));
    });
  });
}
