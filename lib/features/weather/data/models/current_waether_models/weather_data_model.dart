part of weather_forecasting;

class WeatherDataModel extends WeatherData {
  const WeatherDataModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      WeatherDataModel(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );
}
