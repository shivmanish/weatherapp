part of weather_forecasting;

class Coord extends Equatable {
  final double lon;
  final double lat;

  const Coord({required this.lon, required this.lat});

  @override
  List<Object> get props => [lon, lat];
}
