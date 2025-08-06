part of weather_forecasting;

class GetMarkerInfo implements WeatherUseCase<MarkerInfo, WeatherParams> {
  final MapRepository repository;

  GetMarkerInfo(this.repository);
  @override
  Future<dartz.Either<Failure, MarkerInfo>> call(WeatherParams params) async {
    return await repository.getMarkerInfo(params.latLong);
  }
}
