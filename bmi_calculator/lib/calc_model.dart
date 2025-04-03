import 'dart:math';

class CalcModel {
  final int height;
  final int weight;

  double _bmi = 0;

  CalcModel({required this.height, required this.weight});

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String get result {
    print(_bmi);
    if (_bmi >= 25) {
      return 'Sobrepeso';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'Magro';
    }
  }

  String get interpretation {
    if (_bmi >= 25) {
      return 'Você está com o peso acima do ideal. Tente exercitar mais.';
    } else if (_bmi >= 18.5) {
      return 'Seu peso está ideal para sua altura. Bom trabalho!';
    } else {
      return 'Seu peso está abaixo do ideal. Tente comer um pouco mais.';
    }
  }
}
