// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:very_good_weather/l10n/l10n.dart';
import 'package:very_good_weather/permissions/cubit/permissions_cubit.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.weatherRepository,
    required this.geoLocationRepository,
    this.themeData,
    Key? key,
  }) : super(key: key);

  final WeatherRepository weatherRepository;
  final GeoLocationRepository geoLocationRepository;
  final ThemeData? themeData;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: weatherRepository),
        RepositoryProvider.value(value: geoLocationRepository),
      ],
      child: RepositoryProvider.value(
        value: weatherRepository,
        child: MaterialApp(
          theme: themeData ?? ThemeData(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => WeatherCubit(
                  context.read<WeatherRepository>(),
                  context.read<GeoLocationRepository>(),
                ),
              ),
              BlocProvider(
                create: (BuildContext context) => PermissionsCubit(
                  context.read<GeoLocationRepository>(),
                ),
              ),
            ],
            child: const WeatherPage(),
          ),
        ),
      ),
    );
  }
}
