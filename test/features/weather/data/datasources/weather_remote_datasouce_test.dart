import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../fixture/fixture_reader.dart';
import 'weather_remote_datasouce_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDataSourceImpl dataSourceImpl;
  late MockClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockClient();
    dataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getCurrentWeather', () {
    final tLatlng = LatLong(lat: 0, long: 0);
    final tCurrentWeatherModel = CurrentWeatherModel.fromJson(
      json.decode(fixture('current_weather.json')),
    );

    test('should perform a GET request with correct URL and headers', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('current_weather.json'), 200),
      );

      // act
      await dataSourceImpl.getCurrentWeather(tLatlng);

      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(
            "$baseUrl/weather?lat=${tLatlng.lat}&lon=${tLatlng.long}&units=metric&appid=$apiKey",
          ),
          headers: {'content-Type': 'application/json'},
        ),
      );
    });

    test(
      'should return CurrentWeatherModel when response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('current_weather.json'), 200),
        );

        // act
        final result = await dataSourceImpl.getCurrentWeather(tLatlng);

        // assert
        expect(result, tCurrentWeatherModel);
      },
    );

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('error', 404));

        // act
        final call = dataSourceImpl.getCurrentWeather;

        // assert
        expect(() => call(tLatlng), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getHourlyWeather', () {
    final tLatlng = LatLong(lat: 0, long: 0);
    final tHourlyWeatherModel = HourlyWeatherForecastModel.fromJson(
      json.decode(fixture('hourly_weather.json')),
    );

    test('should perform a GET request with correct URL and headers', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('hourly_weather.json'), 200),
      );

      // act
      await dataSourceImpl.getHourlyWeather(tLatlng);

      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(
            '$baseUrl/forecast?lat=${tLatlng.lat}&lon=${tLatlng.long}&units=metric&appid=$apiKey',
          ),
          headers: {'content-Type': 'application/json'},
        ),
      );
    });

    test(
      'should return HourlyWeatherForecastModel when response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('hourly_weather.json'), 200),
        );

        // act
        final result = await dataSourceImpl.getHourlyWeather(tLatlng);

        // assert
        expect(result, tHourlyWeatherModel);
      },
    );

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('error', 404));

        // act
        final call = dataSourceImpl.getHourlyWeather;

        // assert
        expect(() => call(tLatlng), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getWeeklyWeather', () {
    final tLatlng = LatLong(lat: 0, long: 0);
    final tWeeklyWeatherModel = WeeklyWeatherModel.fromJson(
      json.decode(fixture('weekly_weather.json')),
    );

    test('should perform a GET request with correct URL and headers', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('weekly_weather.json'), 200),
      );

      // act
      await dataSourceImpl.getWeeklyWeather(tLatlng);

      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(
            '$weeklyWeatherUrl&latitude=${tLatlng.lat}&longitude=${tLatlng.long}',
          ),
          headers: {'content-Type': 'application/json'},
        ),
      );
    });

    test(
      'should return WeeklyWeatherModel when response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('weekly_weather.json'), 200),
        );

        // act
        final result = await dataSourceImpl.getWeeklyWeather(tLatlng);

        // assert
        expect(result, tWeeklyWeatherModel);
      },
    );

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('error', 404));

        // act
        final call = dataSourceImpl.getWeeklyWeather;

        // assert
        expect(() => call(tLatlng), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getCityWeather', () {
    final tCityName = 'London';
    final tCurrentWeatherModel = CurrentWeatherModel.fromJson(
      json.decode(fixture('current_weather.json')),
    );

    test('should perform a GET request with correct URL', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('current_weather.json'), 200),
      );

      // act
      await dataSourceImpl.getCityWeather(tCityName);

      // assert
      verify(
        mockHttpClient.get(
          Uri.parse('$baseUrl/weather?q=$tCityName&units=metric&appid=$apiKey'),
        ),
      );
    });

    test(
      'should return CurrentWeatherModel when response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('current_weather.json'), 200),
        );

        // act
        final result = await dataSourceImpl.getCityWeather(tCityName);

        // assert
        expect(result, tCurrentWeatherModel);
      },
    );

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(any),
        ).thenAnswer((_) async => http.Response('error', 404));

        // act
        final call = dataSourceImpl.getCityWeather;

        // assert
        expect(() => call(tCityName), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
