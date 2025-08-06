import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/mock_weather_repository.mocks.dart';
import '../../../../test_helper/models.dart';

void main() {
  late GetHourlyWeather usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetHourlyWeather(mockRepository);
  });

  test(
    'should get hourly weather data for the LatLong from repository',
    () async {
      // arrange
      when(
        mockRepository.getHourlyWeather(any),
      ).thenAnswer((_) async => Right(tHourlyWeatherForecastModel));
      // act
      final result = await usecase(WeatherParams(latLong: tLatLng));
      // assert
      expect(result, Right(tHourlyWeatherForecastModel));
      verify(mockRepository.getHourlyWeather(tLatLng));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
