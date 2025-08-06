part of weather_forecasting;

abstract class WeatherUseCase<Type, Params> {
  Future<dartz.Either<Failure, Type>> call(Params params);
}
