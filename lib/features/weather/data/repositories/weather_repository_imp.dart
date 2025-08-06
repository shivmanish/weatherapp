part of weather_forecasting;

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<dartz.Either<Failure, CurrentWeather>> getCurrentWeather(
    LatLong latLong,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherRemoteData = await weatherRemoteDataSource
            .getCurrentWeather(latLong);
        return dartz.Right(weatherRemoteData);
      } on ServerException {
        return dartz.Left(ServerFailure());
      }
    } else {
      return dartz.Left(NetworkFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, HourlyWeatherForecast>> getHourlyWeather(
    LatLong latLong,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherRemoteData = await weatherRemoteDataSource
            .getHourlyWeather(latLong);
        return dartz.Right(weatherRemoteData);
      } on ServerException {
        return dartz.Left(ServerFailure());
      }
    } else {
      return dartz.Left(NetworkFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, WeeklyWeather>> getWeeklyWeather(
    LatLong latLong,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherRemoteData = await weatherRemoteDataSource
            .getWeeklyWeather(latLong);
        return dartz.Right(weatherRemoteData);
      } on ServerException {
        return dartz.Left(ServerFailure());
      }
    } else {
      return dartz.Left(NetworkFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, CurrentWeatherModel>> getWeatherByCity(
    String cityName,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final places = await weatherRemoteDataSource.getCityWeather(cityName);

        return dartz.Right(places);
      } on ServerException {
        return dartz.Left(ServerFailure());
      }
    } else {
      return dartz.Left(NetworkFailure());
    }
  }
}
