part of weather_forecasting;

class HourlyWeatherData extends Equatable {
  final int dt;
  final MainWeather main;
  final List<WeatherData> weather;
  final int clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final String sys;
  final DateTime? dtTxt;
  final String time;
  final String image;

  const HourlyWeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    required this.image,
    required this.time,
  });

  @override
  List<Object?> get props => [
    dt,
    main,
    weather,
    clouds,
    wind,
    visibility,
    pop,
    sys,
    dtTxt,
  ];
}
