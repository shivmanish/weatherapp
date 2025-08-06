part of weather_forecasting;

class WeeklyWeatherModel extends WeeklyWeather {
  const WeeklyWeatherModel({required super.sevenDayWeatherdata});

  factory WeeklyWeatherModel.fromJson(Map<String, dynamic> json) {
    List<WeeklyWeatherData> data = [];
    Map<String, dynamic> dailydData = json['daily'];
    for (int i = 0; i < (dailydData['time'] as List<dynamic>).length; i++) {
      String day = DateFormat(
        'EEEE',
      ).format(DateTime.parse(dailydData['time'][i])).substring(0, 3);
      String name = getWeatherNameFromCode(dailydData['weather_code'][i]);
      String image = findIcon(name, false);
      data.add(
        WeeklyWeatherData(
          day: day,
          image: image,
          name: name,
          max: dailydData['temperature_2m_max'][i],
          min: dailydData['temperature_2m_min'][i],
        ),
      );
    }
    return WeeklyWeatherModel(sevenDayWeatherdata: data);
  }

  /// Maps WMO weather codes to descriptive weather names.
  /// These names should match your icon asset logic.
  static String getWeatherNameFromCode(int code) {
    if (code == 0) {
      return "Clear";
    } else if (code >= 1 && code <= 3) {
      return "Clouds";
    } else if (code >= 45 && code <= 48) {
      return "Clouds"; // Fog treated as cloudy
    } else if (code >= 51 && code <= 57) {
      return "Drizzle";
    } else if (code >= 61 && code <= 67) {
      return "Rain";
    } else if (code >= 71 && code <= 77) {
      return "Snow";
    } else if (code >= 80 && code <= 82) {
      return "Rain";
    } else if (code >= 95 && code <= 99) {
      return "Thunderstorm";
    } else {
      return "Clouds"; // Default fallback
    }
  }
}
