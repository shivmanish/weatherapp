part of weather_forecasting;

abstract class WeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather(LatLong latLong);
  Future<HourlyWeatherForecastModel> getHourlyWeather(LatLong latLong);
  Future<WeeklyWeatherModel> getWeeklyWeather(LatLong latLong);
  Future<CurrentWeatherModel> getCityWeather(String query);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentWeatherModel> getCurrentWeather(LatLong latLong) async {
    final response = await client.get(
      Uri.parse(
        "$baseUrl/weather?lat=${latLong.lat}&lon=${latLong.long}&units=metric&appid=$apiKey",
      ),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HourlyWeatherForecastModel> getHourlyWeather(LatLong latLong) async {
    final response = await client.get(
      Uri.parse(
        '$baseUrl/forecast?lat=${latLong.lat}&lon=${latLong.long}&units=metric&appid=$apiKey',
      ),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return HourlyWeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeeklyWeatherModel> getWeeklyWeather(LatLong latLong) async {
    final response = await client.get(
      Uri.parse(
        '$weeklyWeatherUrl&latitude=${latLong.lat}&longitude=${latLong.long}',
      ),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return WeeklyWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CurrentWeatherModel> getCityWeather(String cityName) async {
    var url = Uri.parse(
      '$baseUrl/weather?q=$cityName&units=metric&appid=$apiKey',
    );
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
