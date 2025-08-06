part of weather_forecasting;

abstract class MapRemoteDataSource {
  Future<MapModel> getMaps(String mapType, int x, int y, int zoom);
  Future<MarkerInfoModel> getMarkerInfo(LatLong latLong);
}

class MapRemoteDataSourceImpl extends MapRemoteDataSource {
  final http.Client client;
  MapRemoteDataSourceImpl({required this.client});
  @override
  Future<MapModel> getMaps(String mapType, int x, int y, int zoom) async {
    try {
      final uri = Uri.parse(
        "https://tile.openweathermap.org/map/$mapType/$zoom/$x/$y.png?appid=$apiKey",
      );

      final ByteData imageData = await NetworkAssetBundle(uri).load("");
      return MapModel.fromByteData(imageData);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MarkerInfoModel> getMarkerInfo(LatLong latLong) async {
    final response = await client.get(
      Uri.parse(
        "$baseUrl/weather?lat=${latLong.lat}&lon=${latLong.long}&units=metric&appid=$apiKey",
      ),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return MarkerInfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
