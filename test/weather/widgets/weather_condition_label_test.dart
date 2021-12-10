import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_label.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Weather Condition Label', () {
    testWidgets('Display Clear', (tester) async {
      await tester.pumpApp(
        const WeatherConditionLabel(
          weatherCondition: WeatherCondition.clear,
        ),
      );

      expect(find.text('Clear'), findsOneWidget);
    });
  });
}
