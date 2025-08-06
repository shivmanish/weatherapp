import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/mock_weather_repository.mocks.dart';
import '../../../../test_helper/models.dart';

void main() {
  late GetWeeklyWeather usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetWeeklyWeather(mockRepository);
  });

  test(
    'should get weekly weather data for the LatLong from repository',
    () async {
      // arrange
      when(
        mockRepository.getWeeklyWeather(any),
      ).thenAnswer((_) async => Right(tWeeklyWeatherModel));
      // act
      final result = await usecase(WeatherParams(latLong: tLatLng));
      // assert
      expect(result, Right(tWeeklyWeatherModel));
      verify(mockRepository.getWeeklyWeather(tLatLng));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
