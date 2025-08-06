part of weather_forecasting;

class GetMap implements TileProvider {
  final MapRemoteDataSource mapRemoteDataSource;
  late final Tile transTile;
  Tile? actualTile;
  final String mapType;
  final int tileSize;
  GetMap({
    required this.mapRemoteDataSource,
    required this.mapType,
    this.tileSize = 256,
  }) {
    transTile = Tile(0, 0, Uint8List.fromList([1]));
    actualTile = Tile(0, 0, Uint8List.fromList([1]));
  }

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    zoom = zoom ?? 1;

    if (zoom >= 1 && zoom <= 20) {
      try {
        final response = await mapRemoteDataSource.getMaps(mapType, x, y, zoom);
        actualTile = Tile(tileSize, tileSize, response.uint8list);
        return actualTile!;
      } catch (e) {
        return transTile;
      }
    }
    return transTile;
  }
}
