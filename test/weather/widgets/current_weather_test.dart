import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/current_weather.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import '../../helpers/helpers.dart';

class MockWeather extends Mock implements Weather {}

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

void main() {
  group('Current Weather - Clear', () {
    final mockWeather = MockWeather();
    final mockWeatherCubit = MockWeatherCubit();

    when(() => mockWeather.updatedDate).thenReturn(
      DateTime(
        2021,
        12,
        9,
        12,
      ),
    );
    when(() => mockWeather.condition).thenReturn(WeatherCondition.clear);
    when(() => mockWeather.temp).thenReturn(11);
    when(() => mockWeather.minTemp).thenReturn(0);
    when(() => mockWeather.maxTemp).thenReturn(20);

    when(() => mockWeatherCubit.state).thenReturn(
      const WeatherState(),
    );

    testWidgets('Clear', (tester) async {
      await tester.pumpApp(
        BlocProvider<WeatherCubit>.value(
          value: mockWeatherCubit,
          child: CurrentWeather(weather: mockWeather),
        ),
      );

      await tester.pump();

      expect(find.text('Clear'), findsOneWidget);
    });
  });
}
