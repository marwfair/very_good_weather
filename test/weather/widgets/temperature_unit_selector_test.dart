import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:very_good_weather/weather/widgets/temperature_unit_selector.dart';

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

void main() {
  final mockWeatherCubit = MockWeatherCubit();

  group('Render TemperatureUnitSelector', () {
    testWidgets('Change unit', (tester) async {
      when(() => mockWeatherCubit.state).thenReturn(const WeatherState());

      await tester.pumpWidget(
        BlocProvider<WeatherCubit>.value(
          value: mockWeatherCubit,
          child: const MaterialApp(
            home: TemperatureUnitSelector(),
          ),
        ),
      );

      expect(find.byType(TemperatureUnitSelector), findsOneWidget);
    });
  });
}
