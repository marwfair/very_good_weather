import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_label.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Weather Condition Label', () {
    testWidgets('Display Snow', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.snow,
        ),
      );

      expect(find.text('Snow'), findsOneWidget);
    });

    testWidgets('Display Sleet', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.sleet,
        ),
      );

      expect(find.text('Sleet'), findsOneWidget);
    });

    testWidgets('Display Hail', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.hail,
        ),
      );

      expect(find.text('Hail'), findsOneWidget);
    });

    testWidgets('Display Thunderstorm', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.thunderstorm,
        ),
      );

      expect(find.text('Thunderstorm'), findsOneWidget);
    });

    testWidgets('Display Heavy Rain', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.heavyRain,
        ),
      );

      expect(find.text('Heavy Rain'), findsOneWidget);
    });

    testWidgets('Display Light Rain', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.lightRain,
        ),
      );

      expect(find.text('Light Rain'), findsOneWidget);
    });

    testWidgets('Display Showers', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.showers,
        ),
      );

      expect(find.text('Showers'), findsOneWidget);
    });

    testWidgets('Display Heavy Clouds', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.heavyCloud,
        ),
      );

      expect(find.text('Heavy Clouds'), findsOneWidget);
    });

    testWidgets('Display Light Clouds', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.lightCloud,
        ),
      );

      expect(find.text('Light Clouds'), findsOneWidget);
    });

    testWidgets('Display Clear', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.clear,
        ),
      );

      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('Display Unknown', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.unknown,
        ),
      );

      expect(find.text('Unknown'), findsOneWidget);
    });
  });
}
