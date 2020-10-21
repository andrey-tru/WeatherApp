import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String name;

  const WeatherRequested({this.name}) : assert(name != null);

  @override
  List<Object> get props => [name];
}

class WeatherRefresh extends WeatherEvent {
  final String name;

  const WeatherRefresh({this.name}) : assert(name != null);

  @override
  List<Object> get props => [name];
}