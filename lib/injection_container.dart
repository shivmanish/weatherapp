part of weather_forecasting;

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => AppRouter());

  // features - Weather
  getIt.registerFactory(
    () => WeatherBloc(
      getLatLong: getIt(),
      getCurrentWeather: getIt(),
      getHourlyWeather: getIt(),
      getWeeklyWeather: getIt(),
      getWeatherByCity: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetCurrentWeather(getIt()));
  getIt.registerLazySingleton(() => GetHourlyWeather(getIt()));
  getIt.registerLazySingleton(() => GetWeeklyWeather(getIt()));
  getIt.registerLazySingleton(() => GetWeatherByCityName(getIt()));

  // Repository

  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Data Sources
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: getIt()),
  );

  //feature - map

  getIt.registerFactory(
    () => MapBloc(getLatLong: getIt(), markerInfo: getIt()),
  );
  // Data Sources
  getIt.registerLazySingleton<MapRemoteDataSource>(
    () => MapRemoteDataSourceImpl(client: getIt()),
  );
  // Repository
  getIt.registerLazySingleton<MapRepository>(
    () => MapRepositoryImp(mapRemoteDataSource: getIt(), networkInfo: getIt()),
  );
  // Use cases
  getIt.registerLazySingleton(() => GetMarkerInfo(getIt()));

  // Core-
  getIt.registerLazySingleton<GetLatLong>(() => GetLatLongImpl());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // External
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker.instance);
}
