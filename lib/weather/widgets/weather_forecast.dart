import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';
import 'package:very_good_weather/weather/models/weather.dart';
import 'package:very_good_weather/weather/widgets/current_weather.dart';
import 'package:very_good_weather/weather/widgets/weather_list_item.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  final List<Weather> forecast;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<WeatherCubit>().refreshWeather,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CurrentWeather(weather: forecast.first),
            ),
            const Divider(),
            ListView.separated(
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return WeatherListItem(weather: forecast.sublist(1)[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              shrinkWrap: true,
              itemCount: forecast.length - 1,
            ),
          ],
        ),
      ),
    );
  }
}
