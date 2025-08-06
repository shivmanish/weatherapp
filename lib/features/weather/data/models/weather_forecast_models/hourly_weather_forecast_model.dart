part of weather_forecasting;

class HourlyWeatherForecastModel extends HourlyWeatherForecast {
  const HourlyWeatherForecastModel({
    required super.cod,
    required super.message,
    required super.cnt,
    required super.hourlyWeatherList,
    required super.city,
  });

  factory HourlyWeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherForecastModel(
      cod: json['cod'] ?? '',
      message: json['message'] ?? 0,
      cnt: json['cnt'] ?? 0,
      hourlyWeatherList:
          (json['list'] as List<dynamic>)
              .map((entry) => HourlyWeatherDataModel.fromJson(entry))
              .toList(),
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
    );
  }
}
