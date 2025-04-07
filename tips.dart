



List<int> marks = [65, 87, 56, 99, 87, 56];
final set = Set.of(marks);
var marksString = marks.join('');
var junta = 'Flutter'.split('');

final temp = 3.4;


var result = switch(temp){
    < 10 => 'Very Cold',
    >=10 && <= 18 => 'Cold',
    >=19 && <= 24 => 'Normal',
    >=25 && <= 30 => 'Hot',
    _ => 'Very Hot'
};


void main() {
  int x = 25;
  int y = 35;

  var result = y / x;
  print(result);

  var result2 = y ~/ x; // Arredondar a divisão
  print(result2);
}



  // y é um parametro opcional
  add(int x, [int y = 0]) => x + y;


// Named Optional
calculateArea({double width = 0.0, double height = 0.0}) => width * height;

// Named required
calculateArea({required double width = 0.0, required double height = 0.0}) => width * height;


final class Animal {}
base class Cat extends Animal {}






enum MesEnum {
  janeiro('Janeiro'),
  fevereiro('Fevereiro'),
  marco('Março'),
  abril('Abril'),
  maio('Maio'),
  junho('Junho'),
  julho('Julho'),
  agosto('Agosto'),
  setembro('Setembro'),
  outubro('Outubro'),
  novembro('Novembro'),
  dezembro('Dezembro');

  final String description;

  const MesEnum(this.description);
}

String pegarMes(int mes) {
  final result = switch (mes) {
    1 => MesEnum.janeiro.description,
    2 => MesEnum.fevereiro.description,
    3 => MesEnum.marco.description,
    4 => MesEnum.abril.description,
    5 => MesEnum.maio.description,
    6 => MesEnum.junho.description,
    7 => MesEnum.julho.description,
    8 => MesEnum.agosto.description,
    9 => MesEnum.setembro.description,
    10 => MesEnum.outubro.description,
    11 => MesEnum.novembro.description,
    12 => MesEnum.dezembro.description,
    _ => 'Mês inválido', //Valor padrão, substitui o default
  };
  return result;
}

void main() {
  int mes = 1;
  String result = pegarMes(mes);

  print(result);
}