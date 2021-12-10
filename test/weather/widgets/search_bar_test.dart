import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:very_good_weather/weather/widgets/search_bar.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import '../../helpers/helpers.dart';

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeather extends Mock implements Weather {}

void main() {
  group('Search Bar', () {
    final mockWeatherCubit = MockWeatherCubit();
    final mockWeather = MockWeather();

    testWidgets('Render SearchBar', (tester) async {
      when(() => mockWeather.location).thenReturn('Nashville');

      when(() => mockWeatherCubit.state).thenReturn(
        WeatherState(
          forecast: <Weather>[mockWeather],
        ),
      );

      await tester.pumpApp(
        BlocProvider<WeatherCubit>.value(
          value: mockWeatherCubit,
          child: const Material(child: SearchBar()),
        ),
      );

      expect(find.byType(SearchBar), findsOneWidget);
    });
  });
}
