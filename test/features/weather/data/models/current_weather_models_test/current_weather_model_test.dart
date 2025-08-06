import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecasting/weather_forecasting.dart';
import '../../../../../fixture/fixture_reader.dart';
import '../../../../../test_helper/models.dart';

void main() {
  // Use the explicit model instance from test_helper/models.dart
  final tModel = tCurrentWeatherModel;

  test('should be a subclass of CurrentWeather entity', () async {
    expect(tModel, isA<CurrentWeather>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('current_weather.json'),
      );
      // act
      final result = CurrentWeatherModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tModel));
    });
  });
}
