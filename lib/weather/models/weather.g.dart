// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
          temp: $checkedConvert('temp', (v) => (v as num).toDouble()),
          minTemp: $checkedConvert('min_temp', (v) => (v as num).toDouble()),
          maxTemp: $checkedConvert('max_temp', (v) => (v as num).toDouble()),
          applicableDate: $checkedConvert(
              'applicable_date', (v) => DateTime.parse(v as String)),
          location: $checkedConvert('location', (v) => v as String),
          woeid: $checkedConvert('woeid', (v) => v as int),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'minTemp': 'min_temp',
        'maxTemp': 'max_temp',
        'applicableDate': 'applicable_date',
        'updatedDate': 'updated_date'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition],
      'temp': instance.temp,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'applicable_date': instance.applicableDate.toIso8601String(),
      'location': instance.location,
      'woeid': instance.woeid,
      'updated_date': instance.updatedDate.toIso8601String(),
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
