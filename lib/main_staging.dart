// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:very_good_weather/app/app.dart';
import 'package:very_good_weather/bootstrap.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  bootstrap(
    () => App(
      weatherRepository: WeatherRepository(),
      geoLocationRepository: const GeoLocationRepository(),
      themeData: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.orange),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.orange),
      ),
    ),
  );
}
