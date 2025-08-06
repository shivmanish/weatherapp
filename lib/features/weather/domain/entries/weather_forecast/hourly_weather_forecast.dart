part of weather_forecasting;

class HourlyWeatherForecast extends Equatable {
  final String cod;
  final int message;
  final int cnt;
  final List<HourlyWeatherData> hourlyWeatherList;
  final City? city;

  const HourlyWeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.hourlyWeatherList,
    required this.city,
  });

  @override
  List<Object?> get props => [cod, message, cnt, hourlyWeatherList, city];
}
