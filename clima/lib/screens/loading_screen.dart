import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../services/location.dart';
import '../services/network.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Position position;
  late final apiKey;
  late final NetworkService networkService;
  late Response response;

  @override
  void initState() {
    super.initState();
    loadKey();
  }

  void loadKey() async {
    await dotenv.load();
    apiKey = dotenv.env['OPENWEATHERMAPKEY'];
    networkService = NetworkService(apiKey: apiKey);
  }

  void getWeather() async {
    LocationService locationService = LocationService();
    try {
      position = await locationService.getCurrentLocation();
      if (kDebugMode) {
        print(position);
      }
      response = await networkService.getData(position);

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CityScreen(weather: response.body),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'PREVISÃO DO TEMPO',
              textAlign: TextAlign.center,
              style: kButtonTextStyle,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });

                  getWeather();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sua Localização',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            if (loading)
              Center(child: SpinKitRing(color: Colors.white, size: 200.0))
            else
              Container(height: 200),
          ],
        ),
      ),
    );
  }
}
