part of weather_forecasting;

class MainWeatherModel extends MainWeather {
  const MainWeatherModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    super.pressure,
    super.humidity,
    super.seaLevel,
    super.grndLevel,
    // super.tempKf,
  });

  factory MainWeatherModel.fromJson(Map<String, dynamic> json) =>
      MainWeatherModel(
        temp: (json['temp'] as num).toDouble(),
        feelsLike: (json['feels_like'] as num).toDouble(),
        tempMin: (json['temp_min'] as num).toDouble(),
        tempMax: (json['temp_max'] as num).toDouble(),
        pressure: json['pressure'],
        humidity: json['humidity'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
        // tempKf: json['temp_kf'],
      );
}
