import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather_cubit.g.dart';

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(const WeatherState());

  final weather_repository.WeatherRepository _weatherRepository;

  Future<void> fetchWeatherFromQuery(String? query) async {
    if (query == null || query.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weatherList = await _weatherRepository.getWeatherFromQuery(query);

      final forecast = weatherList
          .map(
            (weather_repository.Weather weather) =>
                Weather.fromRepository(weather),
          )
          .toList();

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: state.temperatureUnits,
          forecast: forecast
              .map(
                (weather) => weather.copyWith(
                  temp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.temp.toFahrenheit()
                      : weather.temp,
                  minTemp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.minTemp.toFahrenheit()
                      : weather.minTemp,
                  maxTemp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.maxTemp.toFahrenheit()
                      : weather.maxTemp,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> fetchWeatherFromLocation(
    double latitude,
    double longitude,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weatherList = await _weatherRepository.getWeatherFromLocation(
        latitude,
        longitude,
      );

      final forecast = weatherList
          .map(
            (weather_repository.Weather weather) =>
                Weather.fromRepository(weather),
          )
          .toList();

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: state.temperatureUnits,
          forecast: forecast
              .map(
                (weather) => weather.copyWith(
                  temp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.temp.toFahrenheit()
                      : weather.temp,
                  minTemp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.minTemp.toFahrenheit()
                      : weather.minTemp,
                  maxTemp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.maxTemp.toFahrenheit()
                      : weather.maxTemp,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) {
      return;
    }

    try {
      final weatherList = await _weatherRepository
          .getWeatherFromQuery(state.forecast.first.location);

      final forecast = weatherList
          .map(
            (weather_repository.Weather weather) =>
                Weather.fromRepository(weather),
          )
          .toList();

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: state.temperatureUnits,
          forecast: forecast
              .map(
                (weather) => weather.copyWith(
                  temp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.temp.toFahrenheit()
                      : weather.temp,
                  minTemp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.minTemp.toFahrenheit()
                      : weather.minTemp,
                  maxTemp: state.temperatureUnits == TemperatureUnits.fahrenheit
                      ? weather.maxTemp.toFahrenheit()
                      : weather.maxTemp,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  void toggleUnits() {
    if (!state.status.isSuccess) {
      emit(
        state.copyWith(
          temperatureUnits:
              state.temperatureUnits == TemperatureUnits.fahrenheit
                  ? TemperatureUnits.celsius
                  : TemperatureUnits.fahrenheit,
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: state.temperatureUnits == TemperatureUnits.fahrenheit
            ? TemperatureUnits.celsius
            : TemperatureUnits.fahrenheit,
        forecast: state.forecast
            .map(
              (weather) => weather.copyWith(
                temp: state.temperatureUnits == TemperatureUnits.celsius
                    ? weather.temp.toFahrenheit()
                    : weather.temp.toCelsius(),
                minTemp: state.temperatureUnits == TemperatureUnits.celsius
                    ? weather.minTemp.toFahrenheit()
                    : weather.minTemp.toCelsius(),
                maxTemp: state.temperatureUnits == TemperatureUnits.celsius
                    ? weather.maxTemp.toFahrenheit()
                    : weather.maxTemp.toCelsius(),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;

  double toCelsius() => (this - 32) * 5 / 9;
}
