part of weather_forecasting;

class GetWeeklyWeather implements WeatherUseCase<WeeklyWeather, WeatherParams> {
  final WeatherRepository repository;

  GetWeeklyWeather(this.repository);
  @override
  Future<dartz.Either<Failure, WeeklyWeather>> call(
    WeatherParams params,
  ) async {
    return await repository.getWeeklyWeather(params.latLong);
  }
}
