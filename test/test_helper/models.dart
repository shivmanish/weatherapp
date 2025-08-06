import 'package:weather_forecasting/weather_forecasting.dart';

final tLatLng = LatLong(lat: 0, long: 0);

final tMarkerInfoModel = MarkerInfoModel(temp: 30.35, humidity: 62);

// Explicit model instances using shared JSON fixture values
final tCoord = Coord(lon: 77.3141, lat: 28.5895);

final tWeatherDataModel = WeatherDataModel(
  id: 804,
  main: 'Clouds',
  description: 'overcast clouds',
  icon: '04d',
);

final tMainWeatherModel = MainWeatherModel(
  temp: 30.35,
  feelsLike: 33.95,
  tempMin: 30.35,
  tempMax: 30.35,
  pressure: 1003,
  humidity: 62,
  seaLevel: 1003,
  grndLevel: 977,
);

final tWindModel = WindModel(speed: 0.21, deg: 95, gust: 1.64);

final tSysModel = SysModel(
  type: 1,
  id: 7279602,
  country: 'IN',
  sunrise: 1754352864,
  sunset: 1754401145,
);

final tCurrentWeatherModel = CurrentWeatherModel(
  coord: tCoord,
  weather: [tWeatherDataModel],
  base: 'stations',
  main: tMainWeatherModel,
  visibility: 10000,
  wind: tWindModel,
  clouds: 100,
  dt: 1754383492,
  sys: tSysModel,
  timezone: 19800,
  id: 7279602,
  name: 'Gautam Budh Nagar',
  cod: 200,
  day: '',
  image: '',
);

final tCityModel = CityModel(
  id: 7279602,
  name: 'Gautam Budh Nagar',
  coord: tCoord,
  country: 'IN',
  population: 1674714,
  timezone: 19800,
  sunrise: 1754352866,
  sunset: 1754401147,
);

final tHourlyWeatherDataModel = HourlyWeatherDataModel(
  dt: 1754395200,
  main: tMainWeatherModel,
  weather: [tWeatherDataModel],
  clouds: 100,
  wind: tWindModel,
  visibility: 10000,
  pop: 1.0,
  sys: 'd',
  dtTxt: DateTime.parse('2025-08-05 12:00:00'),
  image: '04d',
  time: '12:00',
);

final tHourlyWeatherForecastModel = HourlyWeatherForecastModel(
  cod: '200',
  message: 0,
  cnt: 40,
  hourlyWeatherList: [tHourlyWeatherDataModel],
  city: tCityModel,
);

final tWeeklyWeatherModel = WeeklyWeatherModel(
  sevenDayWeatherdata: [
    WeeklyWeatherData(
      day: 'Tue',
      image: '',
      name: 'Thunderstorm',
      max: 31.6,
      min: 26.3,
    ),
    WeeklyWeatherData(
      day: 'Wed',
      image: '',
      name: 'Rain',
      max: 35.1,
      min: 27.4,
    ),
    // ...add more days as needed
  ],
);
