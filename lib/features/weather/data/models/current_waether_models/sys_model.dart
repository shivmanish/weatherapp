part of weather_forecasting;

class SysModel extends Sys {
  const SysModel({
    required super.type,
    required super.id,
    required super.country,
    required super.sunrise,
    required super.sunset,
  });

  factory SysModel.fromJson(Map<String, dynamic> json) => SysModel(
    type: json['type'] ?? 1,
    id: json['id'],
    country: json['country'],
    sunrise: json['sunrise'],
    sunset: json['sunset'],
  );
}
