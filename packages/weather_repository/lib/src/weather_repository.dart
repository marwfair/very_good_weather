import 'package:meta_weather_api/meta_weather_api.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart';

import 'models/weather.dart';

class WeatherRepository {
  WeatherRepository({MetaWeatherApiClient? metaWeatherApiClient})
      : _metaWeatherApiClient = metaWeatherApiClient ?? MetaWeatherApiClient();

  final MetaWeatherApiClient _metaWeatherApiClient;

  Future<List<Weather>> getWeatherFromQuery(String query) async {
    final List<Location> locations =
    await _metaWeatherApiClient.locationSearch(query);

    return List.from(
        (await _metaWeatherApiClient.getWeather(locations.first.woeid))
            .map((apiWeather) =>
            Weather(
              apiWeather.id,
              apiWeather.weatherState.toCondition,
              apiWeather.minTemp,
              apiWeather.maxTemp,
              apiWeather.theTemp,
              apiWeather.applicableDate,
              locations.first.title,
              locations.first.woeid,
            ))
            .toList());
  }

  Future<List<Weather>> getWeatherFromLocation(double latitude,
      double longitude) async {
    final List<Location> locations =
    await _metaWeatherApiClient.latLngSearch(latitude, longitude);

    return List.from(
        (await _metaWeatherApiClient.getWeather(locations.first.woeid))
            .map((apiWeather) =>
            Weather(
              apiWeather.id,
              apiWeather.weatherState.toCondition,
              apiWeather.minTemp,
              apiWeather.maxTemp,
              apiWeather.theTemp,
              apiWeather.applicableDate,
              locations.first.title,
              locations.first.woeid,
            ))
            .toList());
  }
}

extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.snow:
        return WeatherCondition.snow;
      case WeatherState.sleet:
        return WeatherCondition.sleet;
      case WeatherState.hail:
        return WeatherCondition.hail;
      case WeatherState.thunderstorm:
        return WeatherCondition.thunderstorm;
      case WeatherState.heavyRain:
        return WeatherCondition.heavyRain;
      case WeatherState.lightRain:
        return WeatherCondition.lightRain;
      case WeatherState.showers:
        return WeatherCondition.showers;
      case WeatherState.heavyCloud:
        return WeatherCondition.heavyCloud;
      case WeatherState.lightCloud:
        return WeatherCondition.lightCloud;
      case WeatherState.clear:
        return WeatherCondition.clear;
      default:
        return WeatherCondition.unknown;
    }
  }
}
