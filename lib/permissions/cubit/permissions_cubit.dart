import 'package:bloc/bloc.dart';
import 'package:geo_location_repository/geo_location_repository.dart';
import 'package:meta/meta.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit(this.geoLocationRepository) : super(PermissionsInitial());

  final GeoLocationRepository geoLocationRepository;

  Future<void> requestLocationPermission() async {
    final status = await geoLocationRepository.requestLocationPermission();
    emit(status.toState);
  }

  Future<bool> openLocationSettings() async {
    return geoLocationRepository.openLocationSettings();
  }

  Future<bool> openAppSettings() async {
    return geoLocationRepository.openAppSettings();
  }
}

extension on LocationPermissionStatus {
  PermissionsState get toState {
    switch (this) {
      case LocationPermissionStatus.locationServicesDisabled:
        return PermissionsLocationServicesDisabled();
      case LocationPermissionStatus.locationPermissionDenied:
        return PermissionsLocationPermissionDenied();
      case LocationPermissionStatus.locationPermanentlyDenied:
        return PermissionsLocationPermanentlyDenied();
      case LocationPermissionStatus.locationPermissionGranted:
        return PermissionsGranted();
      case LocationPermissionStatus.unknown:
        return PermissionsUnknown();
    }
  }
}
