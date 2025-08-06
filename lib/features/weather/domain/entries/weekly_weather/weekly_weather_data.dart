part of weather_forecasting;

class WeeklyWeatherData extends Equatable {
  final double max;
  final double min;
  final String name;
  final String day;
  final String image;

  const WeeklyWeatherData({
    required this.max,
    required this.min,
    required this.name,
    required this.day,
    required this.image,
  });

  @override
  List<Object?> get props => [max, min, name, day, image];
}
