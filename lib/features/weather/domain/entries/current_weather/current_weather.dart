part of weather_forecasting;

class CurrentWeather extends Equatable {
  final Coord coord;
  final List<WeatherData> weather;
  final String base;
  final MainWeather main;
  final int? visibility;
  final Wind wind;
  final int clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  final String day;
  final String image;

  const CurrentWeather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.image,
    required this.day,
  });

  @override
  List<Object?> get props => [
    coord,
    weather,
    base,
    main,
    visibility,
    wind,
    clouds,
    dt,
    sys,
    timezone,
    id,
    name,
    cod,
  ];
}
