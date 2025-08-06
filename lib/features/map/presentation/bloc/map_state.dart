part of weather_forecasting;

abstract class MapState extends Equatable {
  final UpdateInfo info;
  const MapState({this.info = UpdateInfo.map});

  @override
  List<Object> get props => [info];
}

enum MapErrorType { location, temperature, precipitation, markerInfo }

enum UpdateInfo { map, marker }

class Temperature extends MapState {}

class Precipitation extends MapState {}

class MapError extends MapState {
  final String message;
  final MapErrorType type;
  const MapError({required this.message, required this.type, super.info});

  @override
  List<Object> get props => [message, type];
}

class CurrentLocationLoaded extends MapState {
  final LatLong latLong;
  const CurrentLocationLoaded({required this.latLong});

  @override
  List<Object> get props => [latLong];
}

class MarkerInfoLoading extends MapState {
  const MarkerInfoLoading({super.info = UpdateInfo.marker});
}

class MarkerInfoLoaded extends MapState {
  final MarkerInfo markerInfo;

  const MarkerInfoLoaded({
    required this.markerInfo,
    super.info = UpdateInfo.marker,
  });

  @override
  List<Object> get props => [markerInfo, info];
}
