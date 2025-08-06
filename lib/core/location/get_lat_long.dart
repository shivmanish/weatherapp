part of weather_forecasting;

abstract class GetLatLong {
  Future<dartz.Either<Failure, LatLong>> getLatLong();
}

class GetLatLongImpl implements GetLatLong {
  @override
  Future<dartz.Either<Failure, LatLong>> getLatLong() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException();
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw LocationException();
      }
      final location = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      return dartz.Right(
        LatLong(lat: location.latitude, long: location.longitude),
      );
    } on LocationException {
      return dartz.Left(LocationFailure());
    }
  }
}
