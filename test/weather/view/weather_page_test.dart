import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/weather/weather.dart';

import '../../helpers/helpers.dart';

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

void main() {
  final mockWeatherCubit = MockWeatherCubit();

  when(() => mockWeatherCubit.state).thenReturn(const WeatherState());
  group('WeatherPage', () {
    testWidgets('Renders WeatherPage', (tester) async {
      await tester.pumpApp(
        BlocProvider<WeatherCubit>.value(
          value: mockWeatherCubit,
          child: const WeatherPage(),
        ),
      );
      expect(find.byType(WeatherPage), findsOneWidget);
    });
  });
}
