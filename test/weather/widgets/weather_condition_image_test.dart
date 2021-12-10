import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_image.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Weather Condition Image', () {
    testWidgets('Render WeatherConditionImage', (tester) async {
      await tester.pumpApp(
        const WeatherConditionImage(
          weatherCondition: WeatherCondition.clear,
        ),
      );

      await tester.pump();

      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
