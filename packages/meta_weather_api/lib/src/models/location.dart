import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.latLng,
  });

  final String title;
  final String locationType;
  final int woeid;
  final LatLng latLng;

  static fromJson(Map<String, dynamic> map) {
    return Location(
      title: map['title'] as String,
      locationType: map['location_type'],
      woeid: map['woeid'] as int,
      latLng: _mapStringToLatLng(map['latt_long'] as String),
    );
  }

  static LatLng _mapStringToLatLng(String input) {
    final List<String> latLngArray = input.split(',');
    return LatLng(
      latitude: double.tryParse(latLngArray[0]) ?? 0,
      longitude: double.tryParse(latLngArray[1]) ?? 0,
    );
  }

  @override
  List<Object?> get props => <Object?>[woeid];
}

class LatLng extends Equatable {
  const LatLng({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => <Object?>[latitude, longitude];
}
