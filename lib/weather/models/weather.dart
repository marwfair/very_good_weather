import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

enum TemperatureUnits {
  fahrenheit,
  celsius,
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.condition,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.applicableDate,
    required this.location,
    required this.woeid,
    required this.updatedDate,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      condition: weather.weatherCondition,
      temp: weather.currentTemp,
      minTemp: weather.minTemp,
      maxTemp: weather.maxTemp,
      applicableDate: weather.date,
      location: weather.location,
      woeid: weather.woeid,
      updatedDate: DateTime.now(),
    );
  }

  final WeatherCondition condition;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final DateTime applicableDate;
  final String location;
  final int woeid;
  final DateTime updatedDate;

  Weather copyWith({
    WeatherCondition? condition,
    double? temp,
    double? minTemp,
    double? maxTemp,
    DateTime? applicableDate,
    String? location,
    int? woeid,
    DateTime? updatedDate,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      temp: temp ?? this.temp,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      applicableDate: applicableDate ?? this.applicableDate,
      location: location ?? this.location,
      woeid: woeid ?? this.woeid,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => <Object?>[
        condition,
        temp,
        minTemp,
        maxTemp,
        location,
        woeid,
        updatedDate,
        applicableDate,
      ];
}
