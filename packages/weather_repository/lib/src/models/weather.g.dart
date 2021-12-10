// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['id'] as int,
      $enumDecode(_$WeatherConditionEnumMap, json['weatherCondition']),
      (json['minTemp'] as num).toDouble(),
      (json['maxTemp'] as num).toDouble(),
      (json['currentTemp'] as num).toDouble(),
      DateTime.parse(json['date'] as String),
      json['location'] as String,
      json['woeid'] as int,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'weatherCondition': _$WeatherConditionEnumMap[instance.weatherCondition],
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'currentTemp': instance.currentTemp,
      'date': instance.date.toIso8601String(),
      'location': instance.location,
      'woeid': instance.woeid,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.snow: 'snow',
  WeatherCondition.sleet: 'sleet',
  WeatherCondition.hail: 'hail',
  WeatherCondition.thunderstorm: 'thunderstorm',
  WeatherCondition.heavyRain: 'heavyRain',
  WeatherCondition.lightRain: 'lightRain',
  WeatherCondition.showers: 'showers',
  WeatherCondition.heavyCloud: 'heavyCloud',
  WeatherCondition.lightCloud: 'lightCloud',
  WeatherCondition.clear: 'clear',
  WeatherCondition.unknown: 'unknown',
};
