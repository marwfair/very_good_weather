part of 'weather_cubit.dart';

enum WeatherStatus {
  initial,
  loading,
  success,
  failure,
}

extension WeatherStatusExt on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;

  bool get isLoading => this == WeatherStatus.loading;

  bool get isSuccess => this == WeatherStatus.success;

  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    this.forecast = const <Weather>[],
    this.temperatureUnits = TemperatureUnits.celsius,
  });

  final WeatherStatus status;
  final List<Weather> forecast;
  final TemperatureUnits temperatureUnits;

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    List<Weather>? forecast,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      forecast: forecast ?? this.forecast,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  static WeatherState fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  @override
  List<Object> get props => <Object>[
        status,
        forecast,
        temperatureUnits,
      ];
}
