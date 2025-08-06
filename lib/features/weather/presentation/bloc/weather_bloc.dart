part of weather_forecasting;

const String locationFailureMessage = "Unable to get the Location";
const String serverFailureMessage = "Unable to get data from database";

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetLatLong getLatLong;
  final GetCurrentWeather getCurrentWeather;
  final GetHourlyWeather getHourlyWeather;
  final GetWeeklyWeather getWeeklyWeather;
  final GetWeatherByCityName getWeatherByCity;

  WeatherBloc({
    required this.getLatLong,
    required this.getCurrentWeather,
    required this.getHourlyWeather,
    required this.getWeeklyWeather,
    required this.getWeatherByCity,
  }) : super(Empty()) {
    on<WeatherEvent>((event, emit) {});
    on<GetWeatherForLatLong>(getWaetherForLatLong);
    on<GetHourlyWeatherForLatLong>(getHourlyWaetherForLatLong);
    on<GetWeeklyWeatherForLatLong>(getWeeklyWaetherForLatLong);
    on<GetWeatherByCity>(getWeatherByCityName);
    on<GetLoactionPermission>(getLocationPermission);
  }

  Future<void> getWaetherForLatLong(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final latLongEither = await getLatLong.getLatLong();

    await latLongEither.fold(
      (failure) {
        emit(
          const Error(
            message: locationFailureMessage,
            type: WeatherType.current,
          ),
        );
      },
      (latLong) async {
        emit(Loading(type: WeatherType.current));
        final failureOrWeather = await getCurrentWeather(
          WeatherParams(latLong: latLong),
        );
        failureOrWeather.fold(
          (failure) {
            emit(
              const Error(
                message: serverFailureMessage,
                type: WeatherType.current,
              ),
            );
          },
          (weather) {
            emit(
              CurrentWeatherLoaded(weather: weather, type: WeatherType.current),
            );
          },
        );
      },
    );
  }

  Future<void> getHourlyWaetherForLatLong(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final latLongEither = await getLatLong.getLatLong();

    await latLongEither.fold(
      (failure) {
        emit(
          const Error(
            message: locationFailureMessage,
            type: WeatherType.forecast,
          ),
        );
      },
      (latLong) async {
        emit(Loading(type: WeatherType.forecast));
        final failureOrWeather = await getHourlyWeather(
          WeatherParams(latLong: latLong),
        );
        failureOrWeather.fold(
          (failure) {
            emit(
              const Error(
                message: serverFailureMessage,
                type: WeatherType.forecast,
              ),
            );
          },
          (weather) {
            emit(
              HourlyWeatherLoaded(
                hourlyWeatherData: weather,
                type: WeatherType.forecast,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> getWeeklyWaetherForLatLong(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final latLongEither = await getLatLong.getLatLong();

    await latLongEither.fold(
      (failure) {
        emit(
          const Error(
            message: locationFailureMessage,
            type: WeatherType.weekly,
          ),
        );
      },
      (latLong) async {
        emit(Loading(type: WeatherType.weekly));
        final failureOrWeather = await getWeeklyWeather(
          WeatherParams(latLong: latLong),
        );
        failureOrWeather.fold(
          (failure) {
            emit(
              const Error(
                message: serverFailureMessage,
                type: WeatherType.weekly,
              ),
            );
          },
          (weather) {
            emit(
              WeeklyWeatherLoaded(
                weeklyWeatherData: weather,
                type: WeatherType.weekly,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> getWeatherByCityName(
    GetWeatherByCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(Loading(type: WeatherType.current));
    final places = await getWeatherByCity(event.cityName);
    await places.fold(
      (failure) {
        emit(
          const Error(message: serverFailureMessage, type: WeatherType.current),
        );
      },
      (data) async {
        emit(CurrentWeatherLoaded(weather: data, type: WeatherType.current));
      },
    );
  }

  Future<void> getLocationPermission(
    GetLoactionPermission event,
    Emitter<WeatherState> emit,
  ) async {
    emit(Loading(type: WeatherType.locationPermission));

    final latLongEither = await getLatLong.getLatLong();

    latLongEither.fold(
      (failure) {
        emit(
          const Error(
            message: locationFailureMessage,
            type: WeatherType.locationPermission,
          ),
        );
      },
      (latLong) {
        emit(
          LocationPerissionLoaded(
            latLong: latLong,
            type: WeatherType.locationPermission,
          ),
        );
      },
    );
  }
}
