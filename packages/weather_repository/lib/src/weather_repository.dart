import 'package:meta_weather_api/meta_weather_api.dart' as meta_weather_api;

import 'models/weather.dart';

class WeatherRepository {
  WeatherRepository(this.metaWeatherApiClient);

  final meta_weather_api.MetaWeatherApiClient metaWeatherApiClient;

  Future<List<Weather>> getWeatherFromQuery(String query) async {
    final List<meta_weather_api.Location> locations =
        await metaWeatherApiClient.locationSearch(query);

    return List.from(
        (await metaWeatherApiClient.getWeather(locations.first.woeid))
            .map((meta_weather_api.Weather apiWeather) => Weather(
                  apiWeather.id,
                  apiWeather.weatherStateName,
                  apiWeather.weatherStateImageUrl,
                  apiWeather.minTemp,
                  apiWeather.maxTemp,
                  apiWeather.theTemp,
                  apiWeather.applicableDate,
                ))
            .toList());
  }

  Future<List<Weather>> getWeatherFromLocation(
      double latitude, double longitude) async {
    final List<meta_weather_api.Location> locations =
        await metaWeatherApiClient.latLngSearch(latitude, longitude);

    return List.from(
        (await metaWeatherApiClient.getWeather(locations.first.woeid))
            .map((meta_weather_api.Weather apiWeather) => Weather(
                  apiWeather.id,
                  apiWeather.weatherStateName,
                  apiWeather.weatherStateImageUrl,
                  apiWeather.minTemp,
                  apiWeather.maxTemp,
                  apiWeather.theTemp,
                  apiWeather.applicableDate,
                ))
            .toList());
  }
}
