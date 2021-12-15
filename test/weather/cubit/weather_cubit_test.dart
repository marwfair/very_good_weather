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
  late Weather nashvilleWeatherCelsius;
  late Weather nashvilleWeatherFahrenheit;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockGeoLocationRepository = MockGeoLocationRepository();
    mockWeather = MockWeather();
    nashvilleWeatherCelsius = Weather(
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
    );

    nashvilleWeatherFahrenheit = Weather(
      condition: weather_repository.WeatherCondition.clear,
      temp: 59,
      minTemp: 50,
      maxTemp: 68,
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
    );

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
      'Successfully fetch weather from query - Fahreheit',
      seed: () {
        return WeatherState(
          status: WeatherStatus.success,
          forecast: <Weather>[nashvilleWeatherFahrenheit],
          temperatureUnits: TemperatureUnits.fahrenheit,
        );
      },
      setUp: () {
        when(() => mockWeatherRepository.getWeatherFromQuery(any())).thenAnswer(
          (_) async => [
            weather_repository.Weather(
              12345,
              weather_repository.WeatherCondition.clear,
              50,
              68,
              59,
              DateTime(2021, 12, 9),
              'Nashville',
              2457170,
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
      act: (cubit) => cubit.fetchWeatherFromQuery('Nashville'),
      expect: () => <dynamic>[
        isA<WeatherState>().having(
          (WeatherState weatherState) => weatherState.status,
          'status',
          WeatherStatus.loading,
        ),
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
          forecast: <Weather>[nashvilleWeatherCelsius],
        );
      },
      setUp: () {
        when(() => mockWeatherRepository.getWeatherFromQuery(any())).thenAnswer(
          (_) async => [
            weather_repository.Weather(
              12345,
              weather_repository.WeatherCondition.clear,
              10,
              20,
              15,
              DateTime(2021, 12, 9),
              'Nashville',
              2457170,
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
      expect: () => [
        isA<WeatherState>().having(
          (state) => state.status,
          'status',
          WeatherStatus.success,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Refresh weather failure',
      seed: () {
        return WeatherState(
          status: WeatherStatus.success,
          forecast: <Weather>[nashvilleWeatherCelsius],
        );
      },
      setUp: () {
        when(() => mockWeatherRepository.getWeatherFromQuery(any()))
            .thenAnswer((_) async => throw Exception());
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.refreshWeather(),
      expect: () => [
        isA<WeatherState>().having(
          (state) => state.status,
          'status',
          WeatherStatus.failure,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Toggle temperature units - Celsius to Fahrenheit',
      seed: () => WeatherState(
        status: WeatherStatus.success,
        forecast: [nashvilleWeatherCelsius],
      ),
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.toggleUnits(),
      expect: () => [
        WeatherState(
          status: WeatherStatus.success,
          temperatureUnits: TemperatureUnits.fahrenheit,
          forecast: [nashvilleWeatherFahrenheit],
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Toggle temperature units - Fahrenheit to Celsius',
      seed: () => WeatherState(
        status: WeatherStatus.success,
        temperatureUnits: TemperatureUnits.fahrenheit,
        forecast: [nashvilleWeatherFahrenheit],
      ),
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.toggleUnits(),
      expect: () => [
        WeatherState(
          status: WeatherStatus.success,
          temperatureUnits: TemperatureUnits.celsius,
          forecast: [nashvilleWeatherCelsius],
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Toggle temperature units in failure state',
      seed: () => const WeatherState(
        status: WeatherStatus.failure,
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
          status: WeatherStatus.failure,
          temperatureUnits: TemperatureUnits.fahrenheit,
        ),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Get user location successfully',
      setUp: () {
        when(() => mockGeoLocationRepository.getUserLocation()).thenAnswer(
          (_) async => UserLocation(
            latitude: 36.167839,
            longitude: -86.778160,
          ),
        );
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.getUserLocation(),
      verify: (_) {
        verify(
          () => mockWeatherRepository.getWeatherFromLocation(
            36.167839,
            -86.778160,
          ),
        ).called(1);
      },
    );

    blocTest<WeatherCubit, WeatherState>(
      'Get user location failure',
      setUp: () {
        when(() => mockGeoLocationRepository.getUserLocation())
            .thenAnswer((_) async => throw Exception);
      },
      build: () => mockHydratedStorage(
        () => WeatherCubit(
          mockWeatherRepository,
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.getUserLocation(),
      expect: () => <WeatherState>[
        const WeatherState(status: WeatherStatus.loading),
        const WeatherState(
          status: WeatherStatus.failure,
        ),
      ],
    );
  });
}
