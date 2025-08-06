part of weather_forecasting;

class GetHourlyWeather
    implements WeatherUseCase<HourlyWeatherForecast, WeatherParams> {
  final WeatherRepository repository;

  GetHourlyWeather(this.repository);
  @override
  Future<dartz.Either<Failure, HourlyWeatherForecast>> call(
    WeatherParams params,
  ) async {
    return await repository.getHourlyWeather(params.latLong);
  }

  /// Filters hourly weather list by a given [date] (formatted as yyyy-MM-dd).
  /// If [date] is null, uses today's date.
  List<HourlyWeatherData> getWeatherByDate({
    required List<HourlyWeatherData> hourlyWeatherList,
    DateTime? date,
  }) {
    final DateTime targetDate = (date ?? DateTime.now()).toLocal();

    return hourlyWeatherList.where((entry) {
      if (entry.dtTxt == null) return false;
      return entry.dtTxt!.year == targetDate.year &&
          entry.dtTxt!.month == targetDate.month &&
          entry.dtTxt!.day == targetDate.day;
    }).toList();
  }
}
