import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/models.dart';
import 'get_marker_info_test.mocks.dart';

@GenerateMocks([MapRepository])
void main() {
  late GetMarkerInfo usecase;
  late MockMapRepository mockMapRepository;

  setUp(() {
    mockMapRepository = MockMapRepository();
    usecase = GetMarkerInfo(mockMapRepository);
  });

  test('should get marker info data for the LatLong from repository', () async {
    // arrange
    when(
      mockMapRepository.getMarkerInfo(any),
    ).thenAnswer((_) async => Right(tMarkerInfoModel));

    // act
    final result = await usecase(WeatherParams(latLong: tLatLng));
    // assert
    expect(result, Right(tMarkerInfoModel));
    verify(mockMapRepository.getMarkerInfo(tLatLng));
    verifyNoMoreInteractions(mockMapRepository);
  });
}
