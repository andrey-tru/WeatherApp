import 'package:bloc/bloc.dart';
import 'package:weather_app/api/Weather.dart';
import 'package:weather_app/api/WeatherApi.dart';
import 'package:weather_app/event/WeatherEvent.dart';
import 'package:weather_app/state/WeatherState.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final String name;
  WeatherBloc(this.name) : super(null) {
    add(WeatherRequested(name: name));
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();
      try {
        final Weather weather = await WeatherApi().getWeather(event.name);
        final List<Weather> weatherList =
            await WeatherApi().getWeekWeather(event.name);
        yield WeatherLoadSuccess(weather, weatherList);
      } catch (_) {
        yield WeatherLoadFailure();
      }
    }

    if (event is WeatherRefresh) {
      try {
        final Weather weather = await WeatherApi().getWeather(event.name);
        final List<Weather> weatherList =
            await WeatherApi().getWeekWeather(event.name);
        yield WeatherLoadSuccess(weather, weatherList);
      } catch (_) {
        yield WeatherLoadFailure();
      }
    }
  }
}
