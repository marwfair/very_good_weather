// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/app/app.dart';
import 'package:very_good_weather/weather/view/weather_page.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../helpers/helpers.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockGeoLocationRepository extends Mock implements GeoLocationRepository {}

void main() {
  group('App', () {
    testWidgets('Renders WeatherPage', (tester) async {
      await mockHydratedStorage(() async {
        await tester.pumpWidget(
          App(
            weatherRepository: MockWeatherRepository(),
            geoLocationRepository: MockGeoLocationRepository(),
          ),
        );
      });
      expect(find.byType(WeatherPage), findsOneWidget);
    });
  });
}
