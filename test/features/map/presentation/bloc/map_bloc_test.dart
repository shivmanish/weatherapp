import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import '../../../../test_helper/models.dart';
import 'map_bloc_test.mocks.dart';

@GenerateMocks([GetMarkerInfo, GetLatLongImpl])
void main() {
  late MapBloc mapBloc;
  late MockGetMarkerInfo mockGetMarkerInfo;
  late MockGetLatLongImpl mockGetLatLongImpl;
  setUp(() {
    mockGetMarkerInfo = MockGetMarkerInfo();
    mockGetLatLongImpl = MockGetLatLongImpl();
    mapBloc = MapBloc(
      getLatLong: mockGetLatLongImpl,
      markerInfo: mockGetMarkerInfo,
    );
  });
  test("initialState should be Temp", () {
    expect(mapBloc.state, equals(Temperature()));
  });

  group("GetWeatherForLatLong", () {
    test(
      'should emit [Temperature, Temperature] when maptype is temp_new',
      () async* {
        final expected = [Temperature(), Temperature()];
        expectLater(mapBloc.state, emitsInOrder(expected));
        mapBloc.add(GetTempAndPrepForMap("temp_new"));
      },
    );
    test(
      'should emit [Temperature, Precipitation] when mapType is precipitation_new',
      () async* {
        final expected = [Temperature(), Precipitation()];
        expectLater(mapBloc.state, emitsInOrder(expected));
        mapBloc.add(GetTempAndPrepForMap("precipitation_new"));
      },
    );
  });

  group("GetCurrentLocation", () {
    test(
      'should emit [CurrentLocationLoaded] when location is fetched successfully',
      () async {
        // arrange
        when(
          mockGetLatLongImpl.getLatLong(),
        ).thenAnswer((_) async => Right(tLatLng));
        // assert later
        final expected = [isA<CurrentLocationLoaded>()];
        expectLater(mapBloc.stream, emitsInOrder(expected));
        // act
        mapBloc.add(GetCurrentLocation());
      },
    );

    test('should emit [MapError] when location fetch fails', () async {
      // arrange
      when(
        mockGetLatLongImpl.getLatLong(),
      ).thenAnswer((_) async => Left(LocationFailure()));
      // assert later
      final expected = [isA<MapError>()];
      expectLater(mapBloc.stream, emitsInOrder(expected));
      // act
      mapBloc.add(GetCurrentLocation());
    });
  });

  group("GetMarkerInfoData", () {
    test(
      'should emit [MarkerInfoLoading, MarkerInfoLoaded] when marker info is fetched',
      () async {
        // arrange
        when(
          mockGetMarkerInfo(any),
        ).thenAnswer((_) async => Right(tMarkerInfoModel));
        // assert later
        final expected = [isA<MarkerInfoLoading>(), isA<MarkerInfoLoaded>()];
        expectLater(mapBloc.stream, emitsInOrder(expected));
        // act
        mapBloc.add(GetMarkerInfoData(latLong: tLatLng));
      },
    );

    test(
      'should emit [MarkerInfoLoading, MapError] when marker info fetch fails',
      () async {
        // arrange
        when(
          mockGetMarkerInfo(any),
        ).thenAnswer((_) async => Left(LocationFailure()));
        // assert later
        final expected = [isA<MarkerInfoLoading>(), isA<MapError>()];
        expectLater(mapBloc.stream, emitsInOrder(expected));
        // act
        mapBloc.add(GetMarkerInfoData(latLong: tLatLng));
      },
    );
  });
}
