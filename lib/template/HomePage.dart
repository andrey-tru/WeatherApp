import 'package:flutter/material.dart';
import 'package:weather_app/template/WeatherInfo.dart';
import 'package:weather_app/template/WeatherHour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/WeatherBloc.dart';
import 'package:weather_app/state/WeatherState.dart';
import 'package:weather_app/event/WeatherEvent.dart';
import 'package:weather_app/theme/ThemeColor.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  Object name = 'Москва';
  bool active = true;

  ThemeColor themeColor = ThemeColor(
      bgColor: Colors.black87,
      textColor: Colors.white,
      themeIcon: Icons.bedtime_outlined);
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(name),
      child: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoadSuccess) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: this.themeColor.bgColor,
                actions: [
                  IconButton(
                    icon: Icon(
                      this.themeColor.themeIcon,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (active == true) {
                            themeColor = ThemeColor(
                                bgColor: Colors.white,
                                textColor: Colors.black,
                                themeIcon: Icons.wb_sunny_outlined);
                            active = false;
                          } else {
                            themeColor = ThemeColor(
                                bgColor: Colors.black87,
                                textColor: Colors.white,
                                themeIcon: Icons.bedtime_outlined);
                            active = true;
                          }
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: this.themeColor.textColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      name = await Navigator.pushNamed(context, '/search',
                          arguments: themeColor);
                      if (name != null) {
                        BlocProvider.of<WeatherBloc>(context).add(
                          WeatherRequested(name: name),
                        );
                      }
                    },
                  )
                ],
              ),
              body: RefreshIndicator(
                color: Colors.red,
                onRefresh: () {
                  BlocProvider.of<WeatherBloc>(context).add(
                    WeatherRefresh(name: name),
                  );
                  return _refreshCompleter.future;
                },
                child: Container(
                  color: this.themeColor.bgColor,
                  child: ListView(
                    children: [
                      WeatherInfo(
                        weather: state.weather,
                        textColor: this.themeColor.textColor,
                      ),
                      WeatherHour(
                        weatherList: state.weatherList,
                        textColor: this.themeColor.textColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: this.themeColor.bgColor,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: this.themeColor.textColor,
                    size: 30,
                  ),
                  onPressed: () async {
                    name = await Navigator.pushNamed(context, '/search');
                    if (name != null) {
                      BlocProvider.of<WeatherBloc>(context).add(
                        WeatherRequested(name: name),
                      );
                    }
                  },
                )
              ],
            ),
            body: Container(
              color: this.themeColor.bgColor,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: this.themeColor.textColor,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
