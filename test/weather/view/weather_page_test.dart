import 'package:bloc_test/bloc_test.dart';
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
  });
}
