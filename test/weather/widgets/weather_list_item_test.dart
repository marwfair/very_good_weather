import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/weather_list_item.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import '../../helpers/helpers.dart';

class MockWeather extends Mock implements Weather {}

void main() {
  group('Weather List Item', () {
    final mockWeather = MockWeather();

    when(() => mockWeather.applicableDate).thenReturn(
      DateTime(2021, 12, 9),
    );
    when(() => mockWeather.condition).thenReturn(WeatherCondition.clear);
    when(() => mockWeather.minTemp).thenReturn(0);
    when(() => mockWeather.maxTemp).thenReturn(20);

    testWidgets('Check date is Thursday, Dec 9', (tester) async {
      await tester.pumpApp(
        WeatherListItem(weather: mockWeather),
      );

      expect(find.text('Thursday, Dec 9'), findsOneWidget);
    });
  });
}
