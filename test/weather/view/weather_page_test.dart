import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_weather/permissions/cubit/permissions_cubit.dart';
import 'package:very_good_weather/weather/weather.dart';

import '../../helpers/helpers.dart';

class MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {
}

class MockPermissionsCubit extends MockCubit<PermissionsState>
    implements PermissionsCubit {}

class MockGeoLocationRepository extends Mock implements GeoLocationRepository {}

void main() {
  final mockWeatherCubit = MockWeatherCubit();
  final mockPermissionsCubit = MockPermissionsCubit();

  when(() => mockWeatherCubit.state).thenReturn(const WeatherState());
  when(() => mockPermissionsCubit.state).thenReturn(PermissionsInitial());
  group('WeatherPage', () {
    testWidgets('Renders WeatherPage', (tester) async {
      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );
      expect(find.byType(WeatherPage), findsOneWidget);
    });

    testWidgets('Getting started', (tester) async {
      WeatherState weatherState = WeatherState(status: WeatherStatus.initial);

      when(() => mockWeatherCubit.state).thenReturn(weatherState);

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );

      expect(find.byKey(Key('key_getting_started_text')), findsOneWidget);
    });

    testWidgets('Failure state', (tester) async {
      WeatherState weatherState = WeatherState(status: WeatherStatus.failure);

      when(() => mockWeatherCubit.state).thenReturn(weatherState);

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );

      expect(find.byKey(Key('key_error_text')), findsOneWidget);
    });

    testWidgets('Location Services disabled', (tester) async {
      when(() => mockPermissionsCubit.state)
          .thenReturn(PermissionsLocationServicesDisabled());

      whenListen(
        mockPermissionsCubit,
        Stream.fromIterable([PermissionsLocationServicesDisabled()]),
      );

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );

      await tester.tap(
        find.byKey(
          Key('key_gps_button'),
        ),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(Key('key_enable_location_services_dialog')),
          findsOneWidget);
    });

    testWidgets('Location Services disabled', (tester) async {
      whenListen(
        mockPermissionsCubit,
        Stream.fromIterable([PermissionsLocationServicesDisabled()]),
      );

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );

      await tester.tap(
        find.byKey(
          Key('key_gps_button'),
        ),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(Key('key_enable_location_services_dialog')),
          findsOneWidget);
    });

    testWidgets('Location permission denied', (tester) async {
      whenListen(
        mockPermissionsCubit,
        Stream.fromIterable([PermissionsLocationPermissionDenied()]),
      );

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );

      await tester.tap(
        find.byKey(
          Key('key_gps_button'),
        ),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(Key('key_permission_denied_dialog')), findsOneWidget);
    });

    testWidgets('Location permission permanently denied', (tester) async {
      whenListen(
        mockPermissionsCubit,
        Stream.fromIterable([PermissionsLocationPermanentlyDenied()]),
      );

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
            ),
            BlocProvider<PermissionsCubit>.value(
              value: mockPermissionsCubit,
            ),
          ],
          child: const WeatherPage(),
        ),
      );

      await tester.tap(
        find.byKey(Key('key_gps_button')),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      expect(
          find.byKey(
            Key('key_permission_permanently_denied_dialog'),
          ),
          findsOneWidget);
    });
  });
}
