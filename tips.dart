



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
