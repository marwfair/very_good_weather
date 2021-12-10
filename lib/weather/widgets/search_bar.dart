import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/l10n/l10n.dart';
import 'package:very_good_weather/weather/cubit/weather_cubit.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  late WeatherCubit _weatherCubit;
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _weatherCubit = context.read<WeatherCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (BuildContext context, WeatherState state) {
        final location =
            state.forecast.isNotEmpty ? state.forecast.first.location : null;
        _controller.text = location ?? '';

        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: context.l10n.clearState,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () async {
                try {
                  final position = await _determinePosition().onError(
                    (LocationError error, stackTrace) {
                      switch (error) {
                        case LocationError.locationServicesDisabled:
                          showDialog<AlertDialog>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  context.l10n.enableLocationServicesTitle,
                                ),
                                content: Text(
                                  context.l10n.enableLocationServicesMessage,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(context.l10n.okay),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          break;
                        case LocationError.locationPermissionsDenied:
                          showDialog<AlertDialog>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  context.l10n.enableLocationPermissionsTitle,
                                ),
                                content: Text(
                                  context.l10n.enableLocationPermissionsMessage,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(context.l10n.okay),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          break;
                        case LocationError.locationPermanentlyDenied:
                          showDialog<AlertDialog>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  context.l10n.locationPermissionsDeniedTitle,
                                ),
                                content: Text(
                                  context.l10n.locationPermissionsDeniedMessage,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(context.l10n.okay),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          break;
                      }

                      throw Exception();
                    },
                  );

                  await _weatherCubit.fetchWeatherFromLocation(
                    position.latitude,
                    position.longitude,
                  );
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Icon(
                Icons.gps_fixed,
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

  /// Returns the current [Position] for the user.
  ///
  /// This method will also prompt the user for permissions.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(LocationError.locationServicesDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
          LocationError.locationPermissionsDenied,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        LocationError.locationPermanentlyDenied,
      );
    }

    return Geolocator.getCurrentPosition();
  }
}

enum LocationError {
  locationServicesDisabled,
  locationPermissionsDenied,
  locationPermanentlyDenied,
}
