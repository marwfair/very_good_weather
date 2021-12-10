import 'dart:convert';

import 'package:http/http.dart' as http;

import '../meta_weather_api.dart';

/// Exception thrown when no Locations are returned.
class LocationNotFoundException implements Exception {}

/// Exception thrown when Location request fails.
class LocationRequestException implements Exception {}

/// Exception thrown when no Weathers are returned.
class WeatherNotFoundException implements Exception {}

/// Exception thrown when Weather request fails.
class WeatherRequestException implements Exception {}

/// Client to fetch weather and location information from metaweather.com.
/// https://www.metaweather.com/api/
class MetaWeatherApiClient {
  MetaWeatherApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const String _baseUrl = 'www.metaweather.com';
  final http.Client _httpClient;

  Future<List<Location>> locationSearch(String query) async {
    final Uri uri = Uri.https(
      _baseUrl,
      '/api/location/search',
      <String, String>{'query': query},
    );

    return await fetchLocationData(uri);
  }

  Future<List<Location>> latLngSearch(double latitude, double longitude) async {
    final Uri uri = Uri.https(
      _baseUrl,
      '/api/location/search',
      <String, String>{'lattlong': '$latitude,$longitude'},
    );

    return await fetchLocationData(uri);
  }

  Future<List<Location>> fetchLocationData(Uri uri) async {
    final http.Response locationResponse = await _httpClient.get(uri);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestException();
    }

    final List locationJson = jsonDecode(
      locationResponse.body,
    ) as List;

    if (locationJson.isEmpty) {
      throw LocationNotFoundException();
    }

    return List<Location>.from(
        locationJson.map((json) => Location.fromJson(json)).toList());
  }

  Future<List<Weather>> getWeather(int woeid) async {
    final Uri weatherRequest = Uri.https(
      _baseUrl,
      '/api/location/$woeid',
    );

    final http.Response weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestException();
    }

    final Map<String, dynamic> weatherJson = jsonDecode(
      weatherResponse.body,
    ) as Map<String, dynamic>;

    if (weatherJson.isEmpty) {
      throw WeatherNotFoundException();
    }

    final List consolidatedWeatherList =
        weatherJson['consolidated_weather'] as List;

    if (consolidatedWeatherList.isEmpty) {
      throw WeatherNotFoundException();
    }

    return List<Weather>.from(
        consolidatedWeatherList.map((json) => Weather.fromJson(json)).toList());
  }
}
