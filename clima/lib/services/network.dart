import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final String apiKey;

  NetworkService({required this.apiKey});

  Future<http.Response> getData(Position position) async {
    return await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?'
        'lat=${position.latitude}&lon=${position.longitude}&units=metric&lang=pt_br&appid=$apiKey',
      ),
    );
  }
}
