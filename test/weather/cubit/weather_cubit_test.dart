import 'package:bloc_test/bloc_test.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

import '../../helpers/helpers.dart';

class MockWeatherRepository extends Mock
    implements weather_repository.WeatherRepository {}

class MockGeoLocationRepository extends Mock implements GeoLocationRepository {}

class MockWeather extends Mock implements weather_repository.Weather {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late MockGeoLocationRepository mockGeoLocationRepository;
  late weather_repository.Weather mockWeather;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockGeoLocationRepository = MockGeoLocationRepository();
    mockWeather = MockWeather();

    when(() => mockWeather.weatherCondition)
        .thenReturn(weather_repository.WeatherCondition.clear);
    when(() => mockWeather.currentTemp).thenReturn(15);
    when(() => mockWeather.minTemp).thenReturn(10);
    when(() => mockWeather.maxTemp).thenReturn(20);
    when(() => mockWeather.location).thenReturn('Nashville');
    when(() => mockWeather.date).thenReturn(
      DateTime(
        2021,
        12,
        9,
        12,
      ),
    );
    when(() => mockWeather.id).thenReturn(12345);
    when(() => mockWeather.woeid).thenReturn(2457170);
  });

  group('WeatherCubit', () {
    test('Initial WeatherState', () {
      final weatherCubit = mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      );
      expect(weatherCubit.state, const WeatherState());
    });

    blocTest<WeatherCubit, WeatherState>(
      'Emits empty array with empty query',
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.fetchWeatherFromQuery(null),
      expect: () => <dynamic>[],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Successfully fetch weather from query',
      setUp: () {
        when(() => mockWeatherRepository.getWeatherFromQuery('Nashville'))
            .thenAnswer((_) async => [mockWeather]);
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.fetchWeatherFromQuery('Nashville'),
      expect: () => <dynamic>[
        const WeatherState(status: WeatherStatus.loading),
        isA<WeatherState>().having(
          (WeatherState weatherState) => weatherState.status,
          'status',
          WeatherStatus.success,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Fetch weather from query failure',
      setUp: () {
        when(() => mockWeatherRepository.getWeatherFromQuery('Nashville'))
            .thenAnswer((_) async => throw Exception());
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.fetchWeatherFromQuery('Nashville'),
      expect: () => <dynamic>[
        const WeatherState(status: WeatherStatus.loading),
        isA<WeatherState>().having(
          (WeatherState weatherState) => weatherState.status,
          'status',
          WeatherStatus.failure,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Successfully fetch weather from location',
      setUp: () {
        when(
          () => mockWeatherRepository.getWeatherFromLocation(
            36.167839,
            -86.778160,
          ),
        ).thenAnswer((_) async => [mockWeather]);
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.fetchWeatherFromLocation(
        36.167839,
        -86.778160,
      ),
      expect: () => <dynamic>[
        const WeatherState(status: WeatherStatus.loading),
        isA<WeatherState>().having(
          (WeatherState weatherState) => weatherState.status,
          'status',
          WeatherStatus.success,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Fetch weather from location failure',
      setUp: () {
        when(
          () => mockWeatherRepository.getWeatherFromLocation(
            36.167839,
            -86.778160,
          ),
        ).thenAnswer((_) async => throw Exception());
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.fetchWeatherFromLocation(
        36.167839,
        -86.778160,
      ),
      expect: () => <dynamic>[
        const WeatherState(status: WeatherStatus.loading),
        isA<WeatherState>().having(
          (WeatherState weatherState) => weatherState.status,
          'status',
          WeatherStatus.failure,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Successfully refresh weather',
      seed: () {
        return WeatherState(
          status: WeatherStatus.success,
          forecast: <Weather>[
            Weather(
              condition: weather_repository.WeatherCondition.clear,
              temp: 15,
              minTemp: 10,
              maxTemp: 20,
              applicableDate: DateTime(
                2021,
                12,
                9,
              ),
              location: 'Nashville',
              woeid: 2457170,
              updatedDate: DateTime(
                2021,
                21,
                9,
                12,
              ),
            ),
          ],
        );
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.refreshWeather(),
      verify: (_) {
        verify(() => mockWeatherRepository.getWeatherFromQuery('Nashville'))
            .called(1);
      },
    );

    blocTest<WeatherCubit, WeatherState>(
      'Toggle temperature units',
      seed: () => const WeatherState(
        status: WeatherStatus.success,
      ),
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.toggleUnits(),
      expect: () => [
        const WeatherState(
          status: WeatherStatus.success,
          temperatureUnits: TemperatureUnits.fahrenheit,
        ),
      ],
    );
  });
}
