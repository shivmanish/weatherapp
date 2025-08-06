part of weather_forecasting;

class CurrentWeatherModel extends CurrentWeather {
  const CurrentWeatherModel({
    required super.coord,
    required super.weather,
    required super.base,
    required super.main,
    super.visibility,
    required super.wind,
    required super.clouds,
    required super.dt,
    required super.sys,
    required super.timezone,
    required super.id,
    required super.name,
    required super.cod,
    required super.day,
    required super.image,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.now();
    return CurrentWeatherModel(
      coord: Coord(
        lon: (json['coord']['lon'] as num).toDouble(),
        lat: (json['coord']['lat'] as num).toDouble(),
      ),
      weather:
          (json['weather'] as List)
              .map((e) => WeatherDataModel.fromJson(e))
              .toList(),
      base: json['base'],
      main: MainWeatherModel.fromJson(json['main']),
      visibility: json['visibility'],
      wind: WindModel.fromJson(json['wind']),
      clouds: json['clouds']['all'],
      dt: json['dt'],
      sys: SysModel.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
      day: DateFormat("EEEE dd MMMM").format(date),
      image: findIcon(json["weather"][0]["main"].toString(), true),
    );
  }
}
