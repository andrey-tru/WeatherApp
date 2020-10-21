import 'package:flutter/material.dart';
import 'package:weather_app/theme/ThemeColor.dart';

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  TextEditingController textFieldController = TextEditingController();
  ThemeColor themeColor;
  @override
  Widget build(BuildContext context) {
    RouteSettings theme = ModalRoute.of(context).settings;
    themeColor = theme.arguments;
    return Scaffold(
      backgroundColor: this.themeColor.bgColor,
      appBar: AppBar(
        backgroundColor: this.themeColor.bgColor,
        iconTheme: IconThemeData(
          color: this.themeColor.textColor, 
        ),
        title: Text(
          'Введите город:',
          style: TextStyle(
            fontSize: 25,
            color: this.themeColor.textColor,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              TextField(
                controller: textFieldController,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  hintText: "Ваш город",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: 30,
                  color: this.themeColor.textColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text(
                  'Ок',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  String cityName = textFieldController.text;
                  Navigator.pop(context, cityName);
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
