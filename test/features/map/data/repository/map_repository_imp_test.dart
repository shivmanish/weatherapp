import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecasting/weather_forecasting.dart';

import 'map_repository_imp_test.mocks.dart';

@GenerateMocks([MapRemoteDataSource, NetworkInfo])
void main() {
  late MapRepositoryImp repository;
  late MockMapRemoteDataSource mockMapRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockMapRemoteDataSource = MockMapRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MapRepositoryImp(
      networkInfo: mockNetworkInfo,
      mapRemoteDataSource: mockMapRemoteDataSource,
    );
  });

  final latLng = LatLong(lat: 0, long: 0);

  final tMarkerInfoModel = MarkerInfoModel(temp: 30.35, humidity: 62);

  final MarkerInfo tMarkerInfo = tMarkerInfoModel;

  group("getMarkerInfo", () {
    test('should check if the device is online', () async {
      // arrange

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(
        mockMapRemoteDataSource.getMarkerInfo(any),
      ).thenAnswer((_) async => tMarkerInfoModel);

      // act
      repository.getMarkerInfo(latLng);

      // assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockMapRemoteDataSource.getMarkerInfo(any),
        ).thenAnswer((_) async => tMarkerInfoModel);
        // act
        final result = await repository.getMarkerInfo(latLng);
        // assert
        verify(mockMapRemoteDataSource.getMarkerInfo(latLng));
        expect(result, equals(Right(tMarkerInfo)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccesful',
      () async {
        // arrange
        when(
          mockMapRemoteDataSource.getMarkerInfo(any),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getMarkerInfo(latLng);
        // assert
        verify(mockMapRemoteDataSource.getMarkerInfo(latLng));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group("device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('should return network failure when the device is offline', () async {
      // arrange
      when(
        mockMapRemoteDataSource.getMarkerInfo(any),
      ).thenThrow(NetWorkException());
      // act
      final result = await repository.getMarkerInfo(latLng);

      // assert

      verifyNever(mockMapRemoteDataSource.getMarkerInfo(latLng));
      expect(result, equals(Left(NetworkFailure())));
    });
  });
}
