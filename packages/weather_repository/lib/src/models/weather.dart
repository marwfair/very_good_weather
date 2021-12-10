import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown,
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather(
    this.id,
    this.weatherCondition,
    this.minTemp,
    this.maxTemp,
    this.currentTemp,
    this.date,
    this.location,
    this.woeid,
  );

  final int id;
  final WeatherCondition weatherCondition;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final DateTime date;
  final String location;
  final int woeid;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => <Object?>[
        id,
        weatherCondition,
        minTemp,
        maxTemp,
        currentTemp,
        date,
      ];
}
