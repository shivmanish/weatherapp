part of weather_forecasting;

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetTempAndPrepForMap extends MapEvent {
  final String mapType;

  const GetTempAndPrepForMap(this.mapType);
}

class GetCurrentLocation extends MapEvent {
  const GetCurrentLocation();
}

class GetMarkerInfoData extends MapEvent {
  final LatLong latLong;
  const GetMarkerInfoData({required this.latLong});
  @override
  List<Object> get props => [latLong];
}
