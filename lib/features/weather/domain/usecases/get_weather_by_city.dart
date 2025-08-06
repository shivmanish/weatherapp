part of weather_forecasting;

class GetWeatherByCityName implements WeatherUseCase<CurrentWeather, String> {
  final WeatherRepository repository;

  GetWeatherByCityName(this.repository);
  @override
  Future<dartz.Either<Failure, CurrentWeather>> call(String cityName) async {
    return await repository.getWeatherByCity(cityName);
  }
}
