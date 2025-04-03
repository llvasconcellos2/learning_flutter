import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  static Future<http.Response> getData(Position position) async {
    return await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?'
        'lat=${position.latitude}&lon=${position.longitude}&appid=${dotenv.env['OPENWEATHERMAPKEY']}',
      ),
    );
  }
}
