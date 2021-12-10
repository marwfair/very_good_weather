import 'package:flutter/material.dart';
import 'package:very_good_weather/l10n/l10n.dart';
import 'package:weather_repository/weather_repository.dart';

/// Widget that maps the [weatherCondition] to [Text].
///
/// If the [textStyle] argument is null, it will default to the Theme's
/// subtitle2.
class WeatherConditionLabel extends StatelessWidget {
  const WeatherConditionLabel({
    Key? key,
    required this.weatherCondition,
    this.textStyle,
  }) : super(key: key);

  final WeatherCondition weatherCondition;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      mapWeatherConditionToText(context, weatherCondition),
      style: textStyle ?? Theme.of(context).textTheme.subtitle2,
    );
  }

  String mapWeatherConditionToText(
    BuildContext context,
    WeatherCondition weatherCondition,
  ) {
    switch (weatherCondition) {
      case WeatherCondition.snow:
        return context.l10n.snowState;
      case WeatherCondition.sleet:
        return context.l10n.sleetState;
      case WeatherCondition.hail:
        return context.l10n.hailState;
      case WeatherCondition.thunderstorm:
        return context.l10n.thunderstormState;
      case WeatherCondition.heavyRain:
        return context.l10n.heavyRainState;
      case WeatherCondition.lightRain:
        return context.l10n.lightRainState;
      case WeatherCondition.showers:
        return context.l10n.showersState;
      case WeatherCondition.heavyCloud:
        return context.l10n.heavyCloudState;
      case WeatherCondition.lightCloud:
        return context.l10n.lightCloudState;
      case WeatherCondition.clear:
        return context.l10n.clearState;
      case WeatherCondition.unknown:
        return context.l10n.unknownState;
    }
  }
}
