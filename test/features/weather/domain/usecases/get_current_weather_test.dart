import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/mock_weather_repository.mocks.dart';
import '../../../../test_helper/models.dart';

void main() {
  late GetCurrentWeather usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockRepository);
  });

  test(
    'should get current weather data for the LatLong from repository',
    () async {
      // arrange
      when(
        mockRepository.getCurrentWeather(any),
      ).thenAnswer((_) async => Right(tCurrentWeatherModel));
      // act
      final result = await usecase(WeatherParams(latLong: tLatLng));
      // assert
      expect(result, Right(tCurrentWeatherModel));
      verify(mockRepository.getCurrentWeather(tLatLng));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
