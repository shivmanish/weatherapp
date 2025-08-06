import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/models.dart' as test_models;
import 'weather_repository_imp_test.mocks.dart';

@GenerateMocks([WeatherRemoteDataSource, NetworkInfo])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tLatLng = test_models.tLatLng;
  final tCurrentWeatherModel = test_models.tCurrentWeatherModel;
  final tHourlyWeatherForecastModel = test_models.tHourlyWeatherForecastModel;
  final tWeeklyWeatherModel = test_models.tWeeklyWeatherModel;
  final tCityName = 'London';

  group('getCurrentWeather', () {
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.getCurrentWeather(any),
      ).thenAnswer((_) async => tCurrentWeatherModel);
      repository.getCurrentWeather(tLatLng);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call is successful', () async {
        when(
          mockRemoteDataSource.getCurrentWeather(any),
        ).thenAnswer((_) async => tCurrentWeatherModel);
        final result = await repository.getCurrentWeather(tLatLng);
        verify(mockRemoteDataSource.getCurrentWeather(tLatLng));
        expect(result, equals(Right(tCurrentWeatherModel)));
      });

      test('should return server failure when call is unsuccessful', () async {
        when(
          mockRemoteDataSource.getCurrentWeather(any),
        ).thenThrow(ServerException());
        final result = await repository.getCurrentWeather(tLatLng);
        verify(mockRemoteDataSource.getCurrentWeather(tLatLng));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when device is offline', () async {
        final result = await repository.getCurrentWeather(tLatLng);
        verifyNever(mockRemoteDataSource.getCurrentWeather(tLatLng));
        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('getHourlyWeather', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return remote data when call is successful', () async {
      when(
        mockRemoteDataSource.getHourlyWeather(any),
      ).thenAnswer((_) async => tHourlyWeatherForecastModel);
      final result = await repository.getHourlyWeather(tLatLng);
      verify(mockRemoteDataSource.getHourlyWeather(tLatLng));
      expect(result, equals(Right(tHourlyWeatherForecastModel)));
    });

    test('should return server failure when call is unsuccessful', () async {
      when(
        mockRemoteDataSource.getHourlyWeather(any),
      ).thenThrow(ServerException());
      final result = await repository.getHourlyWeather(tLatLng);
      verify(mockRemoteDataSource.getHourlyWeather(tLatLng));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return network failure when device is offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getHourlyWeather(tLatLng);
      verifyNever(mockRemoteDataSource.getHourlyWeather(tLatLng));
      expect(result, equals(Left(NetworkFailure())));
    });
  });

  group('getWeeklyWeather', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return remote data when call is successful', () async {
      when(
        mockRemoteDataSource.getWeeklyWeather(any),
      ).thenAnswer((_) async => tWeeklyWeatherModel);
      final result = await repository.getWeeklyWeather(tLatLng);
      verify(mockRemoteDataSource.getWeeklyWeather(tLatLng));
      expect(result, equals(Right(tWeeklyWeatherModel)));
    });

    test('should return server failure when call is unsuccessful', () async {
      when(
        mockRemoteDataSource.getWeeklyWeather(any),
      ).thenThrow(ServerException());
      final result = await repository.getWeeklyWeather(tLatLng);
      verify(mockRemoteDataSource.getWeeklyWeather(tLatLng));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return network failure when device is offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getWeeklyWeather(tLatLng);
      verifyNever(mockRemoteDataSource.getWeeklyWeather(tLatLng));
      expect(result, equals(Left(NetworkFailure())));
    });
  });

  group('getWeatherByCity', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return remote data when call is successful', () async {
      when(
        mockRemoteDataSource.getCityWeather(any),
      ).thenAnswer((_) async => tCurrentWeatherModel);
      final result = await repository.getWeatherByCity(tCityName);
      verify(mockRemoteDataSource.getCityWeather(tCityName));
      expect(result, equals(Right(tCurrentWeatherModel)));
    });

    test('should return server failure when call is unsuccessful', () async {
      when(
        mockRemoteDataSource.getCityWeather(any),
      ).thenThrow(ServerException());
      final result = await repository.getWeatherByCity(tCityName);
      verify(mockRemoteDataSource.getCityWeather(tCityName));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return network failure when device is offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getWeatherByCity(tCityName);
      verifyNever(mockRemoteDataSource.getCityWeather(tCityName));
      expect(result, equals(Left(NetworkFailure())));
    });
  });
}
