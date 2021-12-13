import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';

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
        _createButton(
          '°F',
          context.read<WeatherCubit>().state.temperatureUnits ==
              TemperatureUnits.fahrenheit,
        ),
        const SizedBox(width: 10),
        _createButton(
          '°C',
          context.read<WeatherCubit>().state.temperatureUnits ==
              TemperatureUnits.celsius,
        ),
      ],
    );
  }

  Widget _createButton(String label, bool selected) {
    return IgnorePointer(
      ignoring: selected,
      child: TextButton(
        onPressed: () {
          setState(() {
            context.read<WeatherCubit>().toggleUnits();
          });
        },
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.black12, width: 2),
          backgroundColor: selected ? Colors.grey : Colors.white,
        ),
        child: Text(label),
      ),
    );
  }
}
