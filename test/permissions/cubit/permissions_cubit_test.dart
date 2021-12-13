import 'package:bloc_test/bloc_test.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_weather/permissions/cubit/permissions_cubit.dart';

import '../../helpers/helpers.dart';

class MockGeoLocationRepository extends Mock implements GeoLocationRepository {}

void main() {
  late MockGeoLocationRepository mockGeoLocationRepository;

  setUp(() {
    mockGeoLocationRepository = MockGeoLocationRepository();
  });

  group('PermissionsCubit', () {
    test('Initial PermissionsState', () {
      final permissionsCubit = mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      );
      expect(permissionsCubit.state, isA<PermissionsInitial>());
    });

    blocTest<PermissionsCubit, PermissionsState>(
      'Location Services disabled',
      setUp: () =>
          when(() => mockGeoLocationRepository.requestLocationPermission())
              .thenAnswer(
        (_) async => LocationPermissionStatus.locationServicesDisabled,
      ),
      build: () => mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.requestLocationPermission(),
      expect: () => <dynamic>[isA<PermissionsLocationServicesDisabled>()],
    );

    blocTest<PermissionsCubit, PermissionsState>(
      'Location permission denied',
      setUp: () =>
          when(() => mockGeoLocationRepository.requestLocationPermission())
              .thenAnswer(
        (_) async => LocationPermissionStatus.locationPermissionDenied,
      ),
      build: () => mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.requestLocationPermission(),
      expect: () => <dynamic>[isA<PermissionsLocationPermissionDenied>()],
    );

    blocTest<PermissionsCubit, PermissionsState>(
      'Location permanently denied',
      setUp: () =>
          when(() => mockGeoLocationRepository.requestLocationPermission())
              .thenAnswer(
        (_) async => LocationPermissionStatus.locationPermanentlyDenied,
      ),
      build: () => mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.requestLocationPermission(),
      expect: () => <dynamic>[isA<PermissionsLocationPermanentlyDenied>()],
    );

    blocTest<PermissionsCubit, PermissionsState>(
      'Location permission granted',
      setUp: () =>
          when(() => mockGeoLocationRepository.requestLocationPermission())
              .thenAnswer(
        (_) async => LocationPermissionStatus.locationPermissionGranted,
      ),
      build: () => mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.requestLocationPermission(),
      expect: () => <dynamic>[isA<PermissionsGranted>()],
    );

    blocTest<PermissionsCubit, PermissionsState>(
      'Unknown state',
      setUp: () =>
          when(() => mockGeoLocationRepository.requestLocationPermission())
              .thenAnswer((_) async => LocationPermissionStatus.unknown),
      build: () => mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      ),
      act: (cubit) => cubit.requestLocationPermission(),
      expect: () => <dynamic>[isA<PermissionsUnknown>()],
    );

    test('Open location settings successfully', () async {
      when(() => mockGeoLocationRepository.openLocationSettings())
          .thenAnswer((_) async => true);

      final PermissionsCubit permissionsCubit = mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      );

      expect(await permissionsCubit.openLocationSettings(), true);
    });

    test('Open app settings successfully', () async {
      when(() => mockGeoLocationRepository.openAppSettings())
          .thenAnswer((_) async => true);

      final PermissionsCubit permissionsCubit = mockHydratedStorage(
        () => PermissionsCubit(
          mockGeoLocationRepository,
        ),
      );

      expect(await permissionsCubit.openAppSettings(), true);
    });
  });
}
