part of weather_forecasting;

class GetCurrentWeather
    implements WeatherUseCase<CurrentWeather, WeatherParams> {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);
  @override
  Future<dartz.Either<Failure, CurrentWeather>> call(
    WeatherParams params,
  ) async {
    return await repository.getCurrentWeather(params.latLong);
  }
}
