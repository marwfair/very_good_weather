part of 'permissions_cubit.dart';

@immutable
abstract class PermissionsState {}

class PermissionsInitial extends PermissionsState {}

class PermissionsGranted extends PermissionsState {}

class PermissionsLocationServicesDisabled extends PermissionsState {}

class PermissionsLocationPermissionDenied extends PermissionsState {}

class PermissionsLocationPermanentlyDenied extends PermissionsState {}

class PermissionsUnknown extends PermissionsState {}
