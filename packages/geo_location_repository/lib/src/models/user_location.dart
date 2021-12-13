import 'package:equatable/equatable.dart';

class UserLocation extends Equatable {
  const UserLocation({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => <Object?>[
    latitude,
    longitude,
  ];
}
