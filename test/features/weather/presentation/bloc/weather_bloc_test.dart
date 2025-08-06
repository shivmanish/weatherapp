import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart'; // for Mock, when, any, registerFallbackValue
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/models.dart';
import 'weather_bloc_test.mocks.dart';

@GenerateMocks([
  GetLatLongImpl,
  GetCurrentWeather,
  GetHourlyWeather,
  GetWeeklyWeather,
  GetWeatherByCityName,
])
void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeather mockGetCurrentWeather;
  late MockGetHourlyWeather mockGetHourlyWeather;
  late MockGetWeeklyWeather mockGetWeeklyWeather;
  late MockGetWeatherByCityName mockGetWeatherByCityName;
  late MockGetLatLongImpl mockGetLatLongImpl;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    mockGetHourlyWeather = MockGetHourlyWeather();
    mockGetWeeklyWeather = MockGetWeeklyWeather();
    mockGetWeatherByCityName = MockGetWeatherByCityName();
    mockGetLatLongImpl = MockGetLatLongImpl();
    weatherBloc = WeatherBloc(
      getLatLong: mockGetLatLongImpl,
      getCurrentWeather: mockGetCurrentWeather,
      getHourlyWeather: mockGetHourlyWeather,
      getWeatherByCity: mockGetWeatherByCityName,
      getWeeklyWeather: mockGetWeeklyWeather,
    );
  });

  test("initialState should be Empty", () {
    expect(weatherBloc.state, equals(Empty()));
  });

  group('GetWeatherForLatLong', () {
    test(
      'should emit [Loading, CurrentWeatherLoaded] when data is fetched successfully',
      () async {
        when(
          mockGetLatLongImpl.getLatLong(),
        ).thenAnswer((_) async => Right(tLatLng));
        when(
          mockGetCurrentWeather(any),
        ).thenAnswer((_) async => Right(tCurrentWeatherModel));
        final expected = [
          Loading(type: WeatherType.current),
          isA<CurrentWeatherLoaded>(),
        ];
        expectLater(weatherBloc.stream, emitsInOrder(expected));
        weatherBloc.add(GetWeatherForLatLong());
      },
    );

    test('should emit [Error] when location fetch fails', () async {
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Left(LocationFailure()));
      final expected = [isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetWeatherForLatLong());
    });

    test('should emit [Loading, Error] when weather fetch fails', () async {
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Right(tLatLng));
      when(
        mockGetCurrentWeather(any),
      ).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [Loading(type: WeatherType.current), isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetWeatherForLatLong());
    });
  });

  group('GetHourlyWeatherForLatLong', () {
    test(
      'should emit [Loading, HourlyWeatherLoaded] when data is fetched successfully',
      () async {
        when(
          mockGetLatLongImpl.getLatLong(),
        ).thenAnswer((_) async => Right(tLatLng));
        when(
          mockGetHourlyWeather(any),
        ).thenAnswer((_) async => Right(tHourlyWeatherForecastModel));
        final expected = [
          Loading(type: WeatherType.forecast),
          isA<HourlyWeatherLoaded>(),
        ];
        expectLater(weatherBloc.stream, emitsInOrder(expected));
        weatherBloc.add(GetHourlyWeatherForLatLong());
      },
    );

    test('should emit [Error] when location fetch fails', () async {
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Left(LocationFailure()));
      final expected = [isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetHourlyWeatherForLatLong());
    });

    test('should emit [Loading, Error] when weather fetch fails', () async {
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Right(tLatLng));
      when(
        mockGetHourlyWeather(any),
      ).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [Loading(type: WeatherType.forecast), isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetHourlyWeatherForLatLong());
    });
  });

  group('GetWeeklyWeatherForLatLong', () {
    test(
      'should emit [Loading, WeeklyWeatherLoaded] when data is fetched successfully',
      () async {
        when(
          mockGetLatLongImpl.getLatLong(),
        ).thenAnswer((_) async => Right(tLatLng));
        when(
          mockGetWeeklyWeather(any),
        ).thenAnswer((_) async => Right(tWeeklyWeatherModel));
        final expected = [
          Loading(type: WeatherType.weekly),
          isA<WeeklyWeatherLoaded>(),
        ];
        expectLater(weatherBloc.stream, emitsInOrder(expected));
        weatherBloc.add(GetWeeklyWeatherForLatLong());
      },
    );

    test('should emit [Error] when location fetch fails', () async {
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Left(LocationFailure()));
      final expected = [isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetWeeklyWeatherForLatLong());
    });

    test('should emit [Loading, Error] when weather fetch fails', () async {
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Right(tLatLng));
      when(
        mockGetWeeklyWeather(any),
      ).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [Loading(type: WeatherType.weekly), isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetWeeklyWeatherForLatLong());
    });
  });

  group('GetWeatherByCity', () {
    test(
      'should emit [Loading, CurrentWeatherLoaded] when data is fetched successfully',
      () async {
        when(
          mockGetWeatherByCityName(any),
        ).thenAnswer((_) async => Right(tCurrentWeatherModel));
        final expected = [
          Loading(type: WeatherType.current),
          isA<CurrentWeatherLoaded>(),
        ];
        expectLater(weatherBloc.stream, emitsInOrder(expected));
        weatherBloc.add(GetWeatherByCity(cityName: 'London'));
      },
    );

    test('should emit [Loading, Error] when weather fetch fails', () async {
      when(
        mockGetWeatherByCityName(any),
      ).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [Loading(type: WeatherType.current), isA<Error>()];
      expectLater(weatherBloc.stream, emitsInOrder(expected));
      weatherBloc.add(GetWeatherByCity(cityName: 'London'));
    });
  });
}
