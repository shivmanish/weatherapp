part of weather_forecasting;

class LatLong extends Equatable {
  final double lat;
  final double long;

  const LatLong({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];
}
