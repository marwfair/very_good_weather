import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/permissions/cubit/permissions_cubit.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:very_good_weather/weather/widgets/search_bar.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import '../../helpers/helpers.dart';

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

class MockPermissionCubit extends MockCubit<PermissionsState>
    implements PermissionsCubit {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockGeoLocationRepository extends Mock implements GeoLocationRepository {}

class MockWeather extends Mock implements Weather {}

void main() {
  group('Search Bar', () {
    final mockWeatherCubit = MockWeatherCubit();
    final mockPermissionsCubit = MockPermissionCubit();
    final mockWeatherRepository = MockWeatherRepository();
    final mockGeoLocationRepository = MockGeoLocationRepository();
    final mockWeather = MockWeather();

    testWidgets('Render SearchBar', (tester) async {
      when(() => mockWeather.location).thenReturn('Nashville');

      when(() => mockWeatherCubit.state).thenReturn(
        WeatherState(
          forecast: <Weather>[mockWeather],
        ),
      );

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            )
          ],
          child: const Material(child: SearchBar()),
        ),
      );

      expect(find.byType(SearchBar), findsOneWidget);
    });

    testWidgets('Submit search query', (tester) async {
      await mockHydratedStorage(() async {
        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider<WeatherCubit>.value(
                value: WeatherCubit(
                  mockWeatherRepository,
                  mockGeoLocationRepository,
                ),
              ),
              BlocProvider<PermissionsCubit>.value(
                value: PermissionsCubit(mockGeoLocationRepository),
              ),
            ],
            child: const WeatherPage(),
          ),
        );
      });

      await tester.enterText(find.byType(TextField), 'nashville');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      verify(() => mockWeatherRepository.getWeatherFromQuery('nashville'))
          .called(1);
    });
  });
}
