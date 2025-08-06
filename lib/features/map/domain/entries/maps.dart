part of weather_forecasting;

class Maps extends Equatable {
  final Uint8List uint8list;

  const Maps({required this.uint8list});

  @override
  List<Object?> get props => [uint8list];
}
