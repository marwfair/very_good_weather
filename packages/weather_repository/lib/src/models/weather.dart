import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather(
    this.id,
    this.condition,
    this.conditionImageUrl,
    this.minTemp,
    this.maxTemp,
    this.currentTemp,
    this.date,
  );

  final int id;
  final String condition;
  final String conditionImageUrl;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final DateTime date;

  @override
  List<Object?> get props => <Object?>[
        id,
        condition,
        conditionImageUrl,
        minTemp,
        maxTemp,
        currentTemp,
        date,
      ];
}
