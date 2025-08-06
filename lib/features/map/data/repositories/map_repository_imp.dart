part of weather_forecasting;

class MapRepositoryImp extends MapRepository {
  final MapRemoteDataSource mapRemoteDataSource;
  final NetworkInfo networkInfo;

  MapRepositoryImp({
    required this.mapRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<dartz.Either<Failure, MarkerInfo>> getMarkerInfo(
    LatLong latLong,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final markerRemoteData = await mapRemoteDataSource.getMarkerInfo(
          latLong,
        );
        return dartz.Right(markerRemoteData);
      } on ServerException {
        return dartz.Left(ServerFailure());
      }
    } else {
      return dartz.Left(NetworkFailure());
    }
  }
}
