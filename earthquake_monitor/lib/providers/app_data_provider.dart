import 'dart:convert';

import 'package:earthquake_monitor/models/earthquake_model.dart';
import 'package:earthquake_monitor/utils/helper_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppDataProvider extends ChangeNotifier {
  final baseUrl = Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query');

  double _latitude = 0;
  double _longitude = 0;
  String _starttime = '';
  String _endtime = '';
  OrderBy _orderBy = OrderBy.magnitude;
  String? _currentCity;
  double _maxRadiusKm = 500;
  final double _maxRadiusKmThreshold = 20001.6;
  bool _shouldUseLocation = false;
  final String _format = 'geojson';
  final int _minmagnitude = 4;
  final int _limit = 500;

  Map<String, dynamic> queryParams = {};

  EarthquakeModel? earthquakeModel;

  double get latitude => _latitude;

  double get longitude => _longitude;

  String get starttime => _starttime;

  String get endtime => _endtime;

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

  double get maxRadiusKm => _maxRadiusKm;

  double get maxRadiusKmThreshold => _maxRadiusKmThreshold;

  bool get shouldUseLocation => _shouldUseLocation;

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
    notifyListeners();
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
