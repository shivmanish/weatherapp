part of weather_forecasting;

class MarkerInfoModel extends MarkerInfo {
  const MarkerInfoModel({required super.temp, super.humidity});

  factory MarkerInfoModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> mainWeather = json['main'];
    return MarkerInfoModel(
      temp: (mainWeather['temp'] as num).toDouble(),

      humidity: mainWeather['humidity'],
    );
  }
}
