import 'package:clima/services/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final Position position;
  late final apiKey;
  late Future<Response> response;

  @override
  void initState() {
    super.initState();
    loadKey();
  }

  void loadKey() async {
    await dotenv.load();
  }

  void getLocation() async {
    LocationService locationService = LocationService();
    try {
      position = await locationService.getCurrentLocation();
      response = NetworkService.getData(position);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //print(position);
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
