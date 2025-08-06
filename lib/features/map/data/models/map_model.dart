part of weather_forecasting;

class MapModel extends Maps {
  const MapModel({required super.uint8list});

  factory MapModel.fromByteData(ByteData byteData) {
    final Uint8List bytes = byteData.buffer.asUint8List();
    return MapModel(uint8list: bytes);
  }
}
