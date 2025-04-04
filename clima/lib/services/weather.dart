class WeatherModel {
  String getIcon(int condition) {
    if (condition < 300) {
      return 'images/tstorm3.png';
      //return '🌩';
    } else if (condition < 400) {
      return 'images/light_rain.png';
      // return '🌧';
    } else if (condition < 600) {
      return 'images/shower3.png';
      //return '☔️';
    } else if (condition < 700) {
      return 'images/snow5.png';
      // return '☃️';
    } else if (condition < 800) {
      return 'images/fog.png';
      // return '🌫';
    } else if (condition == 800) {
      return 'images/sunny.png';
      // return '☀️';
    } else if (condition == 801) {
      return 'images/cloudy2.png';
      // return '☁️';
    } else if (condition >= 802) {
      return 'images/overcast.png';
      // return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
