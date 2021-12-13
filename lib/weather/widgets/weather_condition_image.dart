import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_repository/weather_repository.dart';

/// Widget for displaying the correct SVG asset for the [weatherCondition].
class WeatherConditionImage extends StatelessWidget {
  const WeatherConditionImage({
    Key? key,
    required this.weatherCondition,
    this.size = 20,
  }) : super(key: key);

  final WeatherCondition weatherCondition;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      mapWeatherConditionToImage(weatherCondition),
      height: size,
    );
  }

  String mapWeatherConditionToImage(WeatherCondition weatherCondition) {
    switch (weatherCondition) {
      case WeatherCondition.snow:
        return 'svgs/clear.svg';
      case WeatherCondition.sleet:
        return 'svgs/sleet.svg';
      case WeatherCondition.hail:
        return 'svgs/hail.svg';
      case WeatherCondition.thunderstorm:
        return 'svgs/thunderstorm.svg';
      case WeatherCondition.heavyRain:
        return 'svgs/heavy_rain.svg';
      case WeatherCondition.lightRain:
        return 'svgs/light_rain.svg';
      case WeatherCondition.showers:
        return 'svgs/showers.svg';
      case WeatherCondition.heavyCloud:
        return 'svgs/heavy_clouds.svg';
      case WeatherCondition.lightCloud:
        return 'svgs/light_clouds.svg';
      case WeatherCondition.clear:
        return 'svgs/clear.svg';
      case WeatherCondition.unknown:
        return 'svgs/clear.svg';
    }
  }
}
