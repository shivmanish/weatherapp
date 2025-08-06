part of weather_forecasting;

class Wind extends Equatable {
  final double speed;
  final int deg;
  final double? gust;

  const Wind({required this.speed, required this.deg, this.gust});

  @override
  List<Object?> get props => [speed, deg, gust];
}
