import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:very_good_weather/l10n/l10n.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/widgets/search_bar.dart';
import 'package:very_good_weather/weather/widgets/temperature_unit_selector.dart';
import 'package:very_good_weather/weather/widgets/weather_forecast.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: const Center(
              child: SearchBar(),
            ),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(context.l10n.temperatureUnit),
                    const TemperatureUnitSelector(),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async {
                        if (!await launch('https://www.metaweather.com')) {
                          log('Unable to launch url.');
                        }
                      },
                      child: Text(
                        context.l10n.poweredByMetaweather,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue[100],
        body: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (BuildContext context, WeatherState state) {
            if (state.status == WeatherStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.errorSnackBar),
                ),
              );
            }
          },
          builder: (BuildContext context, WeatherState state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return Center(
                  child: Text(context.l10n.getStartedMessage),
                );
              case WeatherStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case WeatherStatus.success:
                return WeatherForecast(forecast: state.forecast);
              case WeatherStatus.failure:
                if (state.forecast.isEmpty) {
                  return Center(
                    child: Text(context.l10n.errorMessage),
                  );
                } else {
                  return WeatherForecast(forecast: state.forecast);
                }
            }
          },
        ),
      ),
    );
  }
}
