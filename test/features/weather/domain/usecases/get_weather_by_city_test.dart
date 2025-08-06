import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/mock_weather_repository.mocks.dart';
import '../../../../test_helper/models.dart';

void main() {
  late GetWeatherByCityName usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetWeatherByCityName(mockRepository);
  });

  final tCityName = 'London';

  test('should get weather data for the city from repository', () async {
    // arrange
    when(
      mockRepository.getWeatherByCity(any),
    ).thenAnswer((_) async => Right(tCurrentWeatherModel));
    // act
    final result = await usecase(tCityName);
    // assert
    expect(result, Right(tCurrentWeatherModel));
    verify(mockRepository.getWeatherByCity(tCityName));
    verifyNoMoreInteractions(mockRepository);
  });
}
