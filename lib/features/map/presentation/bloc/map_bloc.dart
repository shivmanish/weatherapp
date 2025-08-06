part of weather_forecasting;

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetMarkerInfo markerInfo;
  final GetLatLong getLatLong;
  MapBloc({required this.getLatLong, required this.markerInfo})
    : super(Temperature()) {
    on<MapEvent>((event, emit) {});
    on<GetTempAndPrepForMap>((event, emit) {
      if (event.mapType == "temp_new") {
        emit(Temperature());
      } else {
        emit(Precipitation());
      }
    });
    on<GetCurrentLocation>(getCurrentLocationLatLong);
    on<GetMarkerInfoData>(getMarkerInfoForLatLong);
  }

  Future<void> getCurrentLocationLatLong(
    MapEvent event,
    Emitter<MapState> emit,
  ) async {
    {
      final latLongEither = await getLatLong.getLatLong();

      await latLongEither.fold(
        (failure) {
          emit(
            const MapError(
              message: locationFailureMessage,
              type: MapErrorType.location,
            ),
          );
        },
        (latLong) async {
          emit(CurrentLocationLoaded(latLong: latLong));
        },
      );
    }
  }

  Future<void> getMarkerInfoForLatLong(
    GetMarkerInfoData event,
    Emitter<MapState> emit,
  ) async {
    {
      emit(MarkerInfoLoading());
      final markerInfoEither = await markerInfo(
        WeatherParams(latLong: event.latLong),
      );

      await markerInfoEither.fold(
        (failure) {
          emit(
            const MapError(
              message: locationFailureMessage,
              type: MapErrorType.markerInfo,
              info: UpdateInfo.marker,
            ),
          );
        },
        (info) async {
          emit(MarkerInfoLoaded(markerInfo: info));
        },
      );
    }
  }
}
