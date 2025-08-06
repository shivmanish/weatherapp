part of weather_forecasting;

abstract class MapRepository {
  Future<dartz.Either<Failure, MarkerInfo>> getMarkerInfo(LatLong latLong);
}
