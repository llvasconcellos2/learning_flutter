import 'dart:convert';
import 'dart:math';

import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  final String weather;

  const CityScreen({super.key, required this.weather});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late final String wallpaper;
  late final Map<String, dynamic> weather;
  final WeatherModel model = WeatherModel();

  @override
  void initState() {
    super.initState();

    Random random = Random();
    int randomNumber = random.nextInt(3) + 1;

    wallpaper = 'images/$randomNumber.jpg';

    try {
      weather = jsonDecode(widget.weather);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(wallpaper),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, size: 50.0),
                ),
              ),
              Container(padding: EdgeInsets.all(20.0), child: null),
              TextButton(
                onPressed: () {},
                child: Text(weather['name'], style: kButtonTextStyle),
              ),
              SizedBox(height: 30),
              Image.asset(
                model.getIcon(weather['weather'][0]['id']),
                width: 300,
                height: 300,
                fit: BoxFit.fill,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather['main']['temp'].round().toString(),
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey.shade300,
                      shadows: [
                        Shadow(
                          offset: Offset(7, 7),
                          blurRadius: 7,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '°C',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.blueGrey.shade50,
                      shadows: [
                        Shadow(
                          offset: Offset(7, 7),
                          blurRadius: 7,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                weather['weather'][0]['description'].toString().capitalize(),
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  color: Colors.blueGrey.shade50,
                  shadows: [
                    Shadow(
                      offset: Offset(7, 7),
                      blurRadius: 7,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
