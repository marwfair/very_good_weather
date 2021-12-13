import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/weather_forecast.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import '../../helpers/helpers.dart';

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

void main() {
  group('Weather Forecast', () {
    final mockWeatherCubit = MockWeatherCubit();

    final weather = Weather(
      condition: WeatherCondition.clear,
      temp: 10,
      minTemp: 0,
      maxTemp: 12,
      applicableDate: DateTime(2021, 12, 9),
      location: 'Nashville',
      woeid: 12345,
      updatedDate: DateTime(
        2021,
        12,
        9,
        12,
      ),
    );

    testWidgets('Render WeatherForecast', (tester) async {
      when(() => mockWeatherCubit.state).thenReturn(const WeatherState());
      await tester.pumpApp(
        BlocProvider<WeatherCubit>.value(
          value: mockWeatherCubit,
          child: WeatherForecast(
            forecast: <Weather>[weather],
          ),
        ),
      );

      expect(find.byType(WeatherForecast), findsOneWidget);
    });
  });
}
