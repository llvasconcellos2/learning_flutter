import 'dart:convert';

import 'package:earthquake_monitor/models/earthquake_model.dart';
import 'package:earthquake_monitor/utils/helper_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AppDataProvider extends ChangeNotifier {
  final baseUrl = Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query');

  double _latitude = 0;
  double _longitude = 0;
  String _starttime = '';
  String _endtime = '';
  OrderBy _orderBy = OrderBy.magnitude;
  String? _currentCity;
  String? _cityInfo;
  double _maxRadiusKm = 500;
  final double _maxRadiusKmThreshold = 20001.6;
  bool _shouldUseLocation = false;
  final String _format = 'geojson';
  int _minmagnitude = 4;
  final int _limit = 500;

  Map<String, dynamic> queryParams = {};

  EarthquakeModel? earthquakeModel;

  double get latitude => _latitude;

  double get longitude => _longitude;

  String get starttime => _starttime;

  int get minmagnitude => _minmagnitude;

  set minmagnitude(int value){
    _minmagnitude = value;
    _setQueryParams();
    notifyListeners();
  }

  set starttime(String time) {
    _starttime = time;
    _setQueryParams();
    notifyListeners();
  }

  String get endtime => _endtime;

  set endtime(String time) {
    _endtime = time;
    _setQueryParams();
    notifyListeners();
  }

  OrderBy get orderBy => _orderBy;

  set orderBy(OrderBy order) => _orderBy = order;

  void setOrderByValue(String order) {
    try {
      _orderBy = OrderBy.values.firstWhere((OrderBy e) {
        return e.value == order;
      });
    } catch (e) {
      _orderBy = OrderBy.magnitude;
      if (kDebugMode) {
        print(e);
      }
    }
    _setQueryParams();
    getEarthquakeData();
    notifyListeners();
  }

  String? get currentCity => _currentCity;

  String? get cityInfo => _cityInfo;

  double get maxRadiusKm => _maxRadiusKm;

  set maxRadiusKm(double value) {
    _maxRadiusKm = value;
    _setQueryParams();
    notifyListeners();
  }

  double get maxRadiusKmThreshold => _maxRadiusKmThreshold;

  bool get shouldUseLocation => _shouldUseLocation;

  void getLocation(bool value) async {
    _shouldUseLocation = value;
    notifyListeners();
    if (value) {
      final position = await _determinePosition();
      _latitude = position.latitude;
      _longitude = position.longitude;
      _maxRadiusKm = 500;
      _setQueryParams();
      await getCurrentCity(position);
      getEarthquakeData();
    } else {
      _latitude = 0;
      _longitude = 0;
      _maxRadiusKm = _maxRadiusKmThreshold;
      _currentCity = null;
      _setQueryParams();
    }
    notifyListeners();
  }

  Future<void> getCurrentCity(Position position) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placeMarks.isNotEmpty) {
        _currentCity = placeMarks.first.subAdministrativeArea;
        _cityInfo =
            '${placeMarks.first.administrativeArea} - ${placeMarks.first.country}';
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  bool get hasDataLoaded => earthquakeModel != null;

  void _setQueryParams() {
    queryParams['format'] = _format;
    queryParams['starttime'] = _starttime;
    queryParams['endtime'] = _endtime;
    queryParams['minmagnitude'] = _minmagnitude.toString();
    queryParams['orderby'] = _orderBy.value;
    queryParams['limit'] = _limit.toString();
    queryParams['latitude'] = _latitude.toString();
    queryParams['longitude'] = _longitude.toString();
    queryParams['maxradiuskm'] = _maxRadiusKm.toString();
  }

  void init() {
    _starttime = getFormatedDateTime(
      DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
    );
    _endtime = getFormatedDateTime(DateTime.now().millisecondsSinceEpoch);
    _maxRadiusKm = _maxRadiusKmThreshold;
    _setQueryParams();
    getEarthquakeData();
  }

  Future<void> getEarthquakeData() async {
    earthquakeModel = null;
    final uri = Uri.https(baseUrl.authority, baseUrl.path, queryParams);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        earthquakeModel = EarthquakeModel.fromJson(json);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Color getAlertColor(String color) => switch (color) {
    'green' => Colors.green,
    'yellow' => Colors.yellow,
    'orange' => Colors.orange,
    'red' => Colors.red,
    _ => Colors.transparent,
  };
}
//?format=geojson&starttime=2014-01-01&endtime=2014-01-02&minmagnitude=6

enum OrderBy {
  time('time', 'Time Descending'),
  timeAsc('time-asc', 'Time Ascending'),
  magnitude('magnitude', 'Magnitude Descending'),
  magnitudeAsc('magnitude-asc', 'Magnitude Ascending');

  final String value;
  final String label;

  const OrderBy(this.value, this.label);
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
