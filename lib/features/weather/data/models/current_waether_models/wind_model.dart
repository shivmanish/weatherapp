part of weather_forecasting;

class WindModel extends Wind {
  const WindModel({required super.speed, required super.deg, super.gust});

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
    speed: (json['speed'] as num).toDouble(),
    deg: json['deg'],
    gust: (json['gust'] as num?)?.toDouble(),
  );
}
