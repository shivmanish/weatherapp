part of weather_forecasting;

abstract class WeatherEvent extends Equatable {
  const WeatherEvent([List properties = const <dynamic>[]]);
}

class GetWeatherForLatLong extends WeatherEvent {
  GetWeatherForLatLong() : super([]);

  @override
  List<Object?> get props => [];
}

class GetHourlyWeatherForLatLong extends WeatherEvent {
  GetHourlyWeatherForLatLong() : super([]);

  @override
  List<Object?> get props => [];
}

class GetWeeklyWeatherForLatLong extends WeatherEvent {
  GetWeeklyWeatherForLatLong() : super([]);

  @override
  List<Object?> get props => [];
}

class GetWeatherByCity extends WeatherEvent {
  final String cityName;
  GetWeatherByCity({required this.cityName}) : super([cityName]);

  @override
  List<Object?> get props => [cityName];
}

class GetLoactionPermission extends WeatherEvent {
  GetLoactionPermission() : super([]);

  @override
  List<Object?> get props => [];
}
