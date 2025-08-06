import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tMarkerInfoModel = MarkerInfoModel(temp: 30.35, humidity: 62);

  test('should be a subclass of Marker info entity', () async {
    // assert
    expect(tMarkerInfoModel, isA<MarkerInfo>());
  });

  group("fromJson", () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('current_weather.json'),
      );
      // act
      final result = MarkerInfoModel.fromJson(jsonMap);
      // assert

      expect(result, equals(tMarkerInfoModel));
    });
  });
}
