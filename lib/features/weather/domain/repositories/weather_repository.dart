part of weather_forecasting;

abstract class WeatherRepository {
  Future<dartz.Either<Failure, CurrentWeather>> getCurrentWeather(
    LatLong latLong,
  );
  Future<dartz.Either<Failure, HourlyWeatherForecast>> getHourlyWeather(
    LatLong latLong,
  );
  Future<dartz.Either<Failure, WeeklyWeather>> getWeeklyWeather(
    LatLong latLong,
  );

  Future<dartz.Either<Failure, CurrentWeatherModel>> getWeatherByCity(
    String cityName,
  );
}
