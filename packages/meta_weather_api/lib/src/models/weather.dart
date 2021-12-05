class Weather {
  const Weather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateImageUrl,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  final int id;
  final String weatherStateName;
  final String weatherStateImageUrl;
  final String windDirectionCompass;
  final DateTime created;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;

  static fromJson(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int,
      weatherStateName: map['weather_state_name'] as String,
      weatherStateImageUrl:
          _createWeatherStateImageUrl(map['weather_state_abbr'] as String),
      windDirectionCompass: map['wind_direction_compass'],
      created: DateTime.parse(map['created'] as String),
      applicableDate: DateTime.parse(map['applicable_date'] as String),
      minTemp: map['min_temp'] as double,
      maxTemp: map['max_temp'] as double,
      theTemp: map['the_temp'] as double,
      windSpeed: map['wind_speed'] as double,
      windDirection: map['wind_direction'] as double,
      airPressure: map['air_pressure'] as double,
      humidity: map['humidity'] as int,
      visibility: map['visibility'] as double,
      predictability: map['predictability'] as int,
    );
  }

  static String _createWeatherStateImageUrl(String weatherStateAbbr) {
    return 'https://www.metaweather.com/static/img/weather/png/64/$weatherStateAbbr.png';
  }
}
