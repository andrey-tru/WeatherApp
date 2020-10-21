class Weather {
  final String name;
  final String description;
  final int temperature;
  final String icon;
  final DateTime time;

  Weather({
    this.name,
    this.description,
    this.temperature,
    this.icon,
    this.time,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'] as String,
      description: json['weather'][0]['description'] as String,
      temperature: double.parse(json['main']['temp'].toString()).toInt(),
      icon: json['weather'][0]['icon'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
