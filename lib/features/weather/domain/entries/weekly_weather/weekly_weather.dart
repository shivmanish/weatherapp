part of weather_forecasting;

class WeeklyWeather extends Equatable {
  final List<WeeklyWeatherData> sevenDayWeatherdata;

  const WeeklyWeather({required this.sevenDayWeatherdata});

  @override
  List<Object?> get props => [sevenDayWeatherdata];
}
