import 'package:flutter/material.dart';
import 'package:weather_app/api/Weather.dart';

class WeatherHour extends StatelessWidget {
  final List<Weather> weatherList;
  final Color textColor;

  const WeatherHour({Key key, this.weatherList, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 25,
          ),
          child: Text(
            'Почасовой прогноз на 5 дней:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: this.textColor),
          ),
        ),
        Container(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherList.length,
            itemBuilder: (context, i) {
              return Container(
                width: 120,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${weatherList[i].time.day}.${weatherList[i].time.month}',
                        style: TextStyle(fontSize: 12, color: this.textColor),
                      ),
                      Text(
                        '${weatherList[i].time.hour}:${weatherList[i].time.minute}0',
                        style: TextStyle(fontSize: 20, color: this.textColor),
                      ),
                      Text(
                        '${weatherList[i].description}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: this.textColor),
                      ),
                      Image.network(
                        "http://openweathermap.org/img/wn/${weatherList[i].icon}@2x.png",
                        scale: 2,
                      ),
                      Text(
                        '${weatherList[i].temperature}°',
                        style: TextStyle(fontSize: 15, color: this.textColor),
                      ),
                    ],
                  ),
                ),
                // '${weatherList[i].description}'
              );
            },
          ),
        ),
      ],
    );
  }
}
