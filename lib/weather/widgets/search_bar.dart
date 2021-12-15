import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/l10n/l10n.dart';
import 'package:very_good_weather/permissions/cubit/permissions_cubit.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  late WeatherCubit _weatherCubit;
  late PermissionsCubit _permissionsCubit;
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _weatherCubit = context.read<WeatherCubit>();
    _permissionsCubit = context.read<PermissionsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (WeatherState previousState, WeatherState currentState) {
        return currentState.status != WeatherStatus.loading;
      },
      builder: (BuildContext context, WeatherState state) {
        final location =
            state.forecast.isNotEmpty ? state.forecast.first.location : null;
        _controller.text = location ?? '';

        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: context.l10n.city,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () async {
                await _permissionsCubit.requestLocationPermission();
              },
              child: const Icon(
                Icons.gps_fixed,
                key: Key('key_gps_button'),
                color: Colors.black,
              ),
            ),
          ),
          onSubmitted: (String value) {
            _weatherCubit.fetchWeatherFromQuery(value);
          },
        );
      },
    );
  }
}
