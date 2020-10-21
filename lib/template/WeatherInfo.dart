import 'package:flutter/material.dart';
import 'package:weather_app/api/Weather.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  final Color textColor;

  const WeatherInfo({
    Key key,
    this.weather,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '${weather.time.day}.${weather.time.month}',
                  style: TextStyle(fontSize: 30, color: this.textColor),
                ),
                Text(
                  '${weather.name}',
                  style: TextStyle(fontSize: 40, color: this.textColor),
                ),
                Text(
                  '${weather.description}',
                  style: TextStyle(fontSize: 20, color: this.textColor),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Image.network(
                  "http://openweathermap.org/img/wn/${weather.icon}@2x.png",
                  scale: .8,
                ),
                Text(
                  '${weather.temperature}°',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: this.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            // WeekWeather(),
          ],
        ),
      ),
    );
  }
}
