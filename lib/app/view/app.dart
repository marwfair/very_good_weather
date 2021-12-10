// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:very_good_weather/l10n/l10n.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.weatherRepository,
    this.themeData,
    Key? key,
  }) : super(key: key);

  final WeatherRepository weatherRepository;
  final ThemeData? themeData;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
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
        home: BlocProvider(
          create: (BuildContext context) =>
              WeatherCubit(context.read<WeatherRepository>()),
          child: const WeatherPage(),
        ),
      ),
    );
  }
}
