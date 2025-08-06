part of weather_forecasting;

class WeatherParams extends Equatable {
  final LatLong latLong;

  const WeatherParams({required this.latLong});

  @override
  List<Object?> get props => [latLong];
}
