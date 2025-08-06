part of weather_forecasting;

class FamousCity {
  final String name;
  final LatLong latLong;

  const FamousCity({required this.name, required this.latLong});
}

// List of famous cities as a constant
List<FamousCity> famousCities = const [
  FamousCity(name: 'Mumbai', latLong: LatLong(lat: 18.9582, long: 72.8321)),
  FamousCity(name: 'New Delhi', latLong: LatLong(lat: 28.5833, long: 77.2)),
  FamousCity(name: 'Delhi', latLong: LatLong(lat: 28.7041, long: 77.1025)),
  FamousCity(name: 'Kolkata', latLong: LatLong(lat: 22.5744, long: 88.3629)),
  FamousCity(name: 'Pune', latLong: LatLong(lat: 18.5246, long: 73.8786)),
  FamousCity(name: 'Lucknow', latLong: LatLong(lat: 26.8467, long: 80.9462)),
];
