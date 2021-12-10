import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  const Location({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.latLng,
  });

  final String title;
  @JsonKey(name: 'location_type')
  final String locationType;
  final int woeid;
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

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

class LatLngConverter implements JsonConverter<LatLng, String> {
  const LatLngConverter();

  @override
  String toJson(LatLng latLng) {
    return '${latLng.latitude},${latLng.longitude}';
  }

  @override
  LatLng fromJson(String jsonString) {
    final parts = jsonString.split(',');
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }
}
