part of weather_forecasting;

class MarkerInfo extends Equatable {
  final double temp;

  final int? humidity;

  const MarkerInfo({required this.temp, this.humidity});

  @override
  List<Object?> get props => [temp, humidity];
}
