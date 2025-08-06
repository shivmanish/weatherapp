part of weather_forecasting;

class HourlyWeatherDataModel extends HourlyWeatherData {
  const HourlyWeatherDataModel({
    required super.dt,
    required super.main,
    required super.weather,
    required super.clouds,
    required super.wind,
    required super.visibility,
    required super.pop,
    required super.sys,
    required super.dtTxt,
    required super.image,
    required super.time,
  });

  factory HourlyWeatherDataModel.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.parse(json['dt_txt']).toLocal();
    int hour = int.parse(DateFormat("hh").format(dateTime));
    return HourlyWeatherDataModel(
      dt: json['dt'] ?? 0,
      main: MainWeatherModel.fromJson(json['main']),
      weather:
          (json['weather'] as List<dynamic>)
              .map((e) => WeatherDataModel.fromJson(e))
              .toList(),
      clouds: json['clouds']['all'],
      wind: WindModel.fromJson(json['wind']),
      visibility: json['visibility'] ?? 0,
      pop: (json['pop'] ?? 0).toDouble(),
      sys: json['sys']['pod'],
      dtTxt: dateTime,
      image: findIcon(json["weather"][0]["main"].toString(), false),
      time: "${Duration(hours: hour).toString().split(":")[0]}:00",
    );
  }
}
