import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_image.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_label.dart';

/// Widget to display the given [weather].
class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  DateFormat(
                    'MMMM d, h:mm a',
                    Localizations.localeOf(context).toString(),
                  ).format(weather.updatedDate),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
                WeatherConditionImage(
                  weatherCondition: weather.condition,
                  size: 100,
                ),
                const SizedBox(height: 10),
                WeatherConditionLabel(weatherCondition: weather.condition),
              ],
            ),
          ),
        ),
        Flexible(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${weather.temp.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        context.read<WeatherCubit>().state.temperatureUnits ==
                                TemperatureUnits.fahrenheit
                            ? 'F'
                            : 'C',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.arrow_upward,
                      color: Colors.red,
                      size: 15,
                    ),
                    Text('${weather.maxTemp.toStringAsFixed(0)}°'),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_downward,
                      color: Colors.blue,
                      size: 15,
                    ),
                    Text('${weather.minTemp.toStringAsFixed(0)}°'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
