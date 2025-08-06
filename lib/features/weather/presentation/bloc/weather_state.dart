part of weather_forecasting;

enum WeatherType { initial, current, forecast, weekly }

abstract class WeatherState extends Equatable {
  final WeatherType type;
  const WeatherState({this.type = WeatherType.initial});

  @override
  List<Object> get props => [type];
}

class Empty extends WeatherState {}

class Loading extends WeatherState {
  const Loading({required super.type});
}

class CurrentWeatherLoaded extends WeatherState {
  final CurrentWeather weather;

  const CurrentWeatherLoaded({required this.weather, required super.type});

  @override
  List<Object> get props => [weather];
}

class Error extends WeatherState {
  final String message;

  const Error({required this.message, required super.type});

  @override
  List<Object> get props => [message];
}

class HourlyWeatherLoaded extends WeatherState {
  final HourlyWeatherForecast hourlyWeatherData;

  const HourlyWeatherLoaded({
    required this.hourlyWeatherData,
    required super.type,
  });

  @override
  List<Object> get props => [hourlyWeatherData];
}

class WeeklyWeatherLoaded extends WeatherState {
  final WeeklyWeather weeklyWeatherData;

  const WeeklyWeatherLoaded({
    required this.weeklyWeatherData,
    required super.type,
  });

  @override
  List<Object> get props => [weeklyWeatherData];
}
