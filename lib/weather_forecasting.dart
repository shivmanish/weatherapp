library weather_forecasting;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart' as dartz;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

part 'injection_container.dart';

// core bibrary
part 'core/constant/constants.dart';
part 'core/error/exceptions.dart';
part 'core/error/failures.dart';
part 'core/location/get_lat_long.dart';
part 'core/utils/lat_long.dart';
part 'core/network/network_info.dart';
part 'core/utils/size_config.dart';
part 'core/utils/find_icon.dart';
part 'core/usecases/weather_usecase/wether_param.dart';
part 'core/usecases/weather_usecase/weather_usecase.dart';
part 'core/router/app_router.dart';
part 'core/theme/app_theme.dart';

// fetarures related files

// Weather fetaure related files

// Domain layer files
part 'features/weather/domain/entries/current_weather/current_weather.dart';
part 'features/weather/domain/entries/current_weather/sys.dart';
part 'features/weather/domain/entries/current_weather/wind.dart';
part 'features/weather/domain/entries/current_weather/main_weather.dart';
part 'features/weather/domain/entries/current_weather/weather_data.dart';
part 'features/weather/domain/entries/current_weather/coord.dart';
part 'features/weather/domain/entries/weather_forecast/hourly_weather_forecast.dart';
part 'features/weather/domain/entries/weather_forecast/hourly_weather_data.dart';
part 'features/weather/domain/repositories/weather_repository.dart';
part 'features/weather/domain/entries/weather_forecast/city.dart';
part 'features/weather/domain/entries/weekly_weather/weekly_weather_data.dart';
part 'features/weather/domain/entries/weekly_weather/weekly_weather.dart';
part 'features/weather/domain/entries/famous_city.dart';

part 'features/weather/domain/usecases/get_current_weather.dart';
part 'features/weather/domain/usecases/get_hourly_forecast.dart';
part 'features/weather/domain/usecases/get_weekly_weather.dart';
part 'features/weather/domain/usecases/get_weather_by_city.dart';

// data layer files
part 'features/weather/data/models/current_waether_models/sys_model.dart';
part 'features/weather/data/models/current_waether_models/wind_model.dart';
part 'features/weather/data/models/current_waether_models/main_weather_model.dart';
part 'features/weather/data/models/current_waether_models/weather_data_model.dart';
part 'features/weather/data/models/current_waether_models/current_weather_model.dart';
part 'features/weather/data/models/weather_forecast_models/city_model.dart';
part 'features/weather/data/models/weather_forecast_models/hourly_weather_data_model.dart';
part 'features/weather/data/models/weather_forecast_models/hourly_weather_forecast_model.dart';
part 'features/weather/data/datasources/weather_remote_datasource.dart';
part 'features/weather/data/repositories/weather_repository_imp.dart';
part 'features/weather/data/models/weekly_weather_models/weekly_weather_model.dart';

// presentation layer files
part 'features/weather/presentation/bloc/weather_event.dart';
part 'features/weather/presentation/bloc/weather_state.dart';
part 'features/weather/presentation/bloc/weather_bloc.dart';
part 'features/weather/presentation/widgets/current_weather/current_extra_data.dart';
part 'features/weather/presentation/widgets/current_weather/current_main_data.dart';
part 'features/weather/presentation/widgets/current_weather/current_weather_view.dart';
part 'features/weather/presentation/pages/weather_page.dart';
part 'features/weather/presentation/widgets/empty_or_loading.dart';
part 'features/weather/presentation/widgets/today_weather.dart/today_extra_data.dart';
part 'features/weather/presentation/widgets/today_weather.dart/today_weather_view.dart';
part 'features/weather/presentation/widgets/error_widget.dart';
part 'features/weather/presentation/widgets/weekly_weather/weekly_weather_view.dart';
part 'features/weather/presentation/widgets/weekly_weather/weekly_weather_tile.dart';
part 'features/weather/presentation/pages/search_page.dart';

// map feature related files

part 'features/map/domain/entries/maps.dart';
part 'features/map/data/models/map_model.dart';
part 'features/map/data/datasources/map_remote_data_source.dart';
part 'features/map/domain/usecases/get_map.dart';
part 'features/map/presentation/bloc/map_state.dart';
part 'features/map/presentation/bloc/map_event.dart';
part 'features/map/presentation/bloc/map_bloc.dart';
part 'features/map/presentation/pages/map_page.dart';
part 'features/map/domain/entries/marker_info.dart';
part 'features/map/data/models/marker_info_model.dart';
part 'features/map/domain/repositories/map_repository.dart';
part 'features/map/data/repositories/map_repository_imp.dart';
part 'features/map/domain/usecases/get_marker_info.dart';
part 'features/map/presentation/widgets/marker_info_sheet.dart';
