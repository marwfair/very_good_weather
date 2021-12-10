import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_image.dart';
import 'package:very_good_weather/weather/widgets/weather_condition_label.dart';

/// Widget to show the [Weather] object in a ListView.
class WeatherListItem extends StatelessWidget {
  const WeatherListItem({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat(
                  'EEEE, MMM d',
                  Localizations.localeOf(context).toString(),
                ).format(weather.applicableDate),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              WeatherConditionLabel(
                weatherCondition: weather.condition,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              WeatherConditionImage(
                weatherCondition: weather.condition,
                size: 30,
              ),
              const SizedBox(width: 10),
              Column(
                children: <Widget>[
                  Text('${weather.maxTemp.toStringAsFixed(0)}°'),
                  Text('${weather.minTemp.toStringAsFixed(0)}°'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
