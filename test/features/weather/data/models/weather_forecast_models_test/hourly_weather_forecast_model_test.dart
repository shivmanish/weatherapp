import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecasting/weather_forecasting.dart';
import '../../../../../test_helper/models.dart';
import '../../../../../fixture/fixture_reader.dart';

void main() {
  // Always use fromJson for expected value
  final tModel = tHourlyWeatherForecastModel;
  test('should be a subclass of HourlyWeatherForecast entity', () async {
    expect(tModel, isA<HourlyWeatherForecast>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('hourly_weather.json'),
      );
      // act
      final result = HourlyWeatherForecastModel.fromJson(jsonMap);
      final expected = HourlyWeatherForecastModel.fromJson(jsonMap);
      // assert
      expect(result, equals(expected));
    });
  });
}
