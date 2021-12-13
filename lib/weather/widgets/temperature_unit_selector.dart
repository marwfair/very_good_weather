import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/unit_selector_button.dart';

/// Toggle to choose between Fahrenheit and Celsius.
class TemperatureUnitSelector extends StatefulWidget {
  const TemperatureUnitSelector({Key? key}) : super(key: key);

  @override
  TemperatureUnitSelectorState createState() => TemperatureUnitSelectorState();
}

class TemperatureUnitSelectorState extends State<TemperatureUnitSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UnitSelectorButton(
            label: '°F',
            selected: context.read<WeatherCubit>().state.temperatureUnits ==
                TemperatureUnits.fahrenheit,
            onPressed: () {
              setState(() {
                context.read<WeatherCubit>().toggleUnits();
              });
            }),
        const SizedBox(width: 10),
        UnitSelectorButton(
          label: '°C',
          selected: context.read<WeatherCubit>().state.temperatureUnits ==
              TemperatureUnits.celsius,
          onPressed: () {
            setState(
              () {
                context.read<WeatherCubit>().toggleUnits();
              },
            );
          },
        ),
      ],
    );
  }
}
