import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../fixture/fixture_reader.dart';
import 'map_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MapRemoteDataSourceImpl dataSourceImpl;
  late MockClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockClient();
    dataSourceImpl = MapRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("getMrkerInfo", () {
    final tLatlng = LatLong(lat: 0, long: 0);

    final tMarkerInfoModel = MarkerInfoModel.fromJson(
      json.decode(fixture("current_weather.json")),
    );

    test(
      '''should perform a GET request on a URL with lat 
         long being the endpoint and with application/json header''',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("current_weather.json"), 200),
        );

        // act
        dataSourceImpl.getMarkerInfo(tLatlng);

        // assert
        verify(
          mockHttpClient.get(
            Uri.parse(
              "$baseUrl/weather?lat=${tLatlng.lat}&lon=${tLatlng.long}&units=metric&appid=$apiKey",
            ),
            headers: {'content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return Marker info when the response code is 200 (success)',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("current_weather.json"), 200),
        );

        // act
        final result = await dataSourceImpl.getMarkerInfo(tLatlng);

        // assert

        expect(result, tMarkerInfoModel);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(any, headers: anyNamed("headers")),
        ).thenAnswer((_) async => http.Response("something went wrong", 404));

        // act
        final call = dataSourceImpl.getMarkerInfo;

        // assert
        expect(() => call(tLatlng), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
