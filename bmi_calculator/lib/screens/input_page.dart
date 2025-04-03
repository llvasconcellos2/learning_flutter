import 'package:bmi_calculator/calc_model.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/box.dart';
import '../components/calc_button.dart';
import '../components/icon_content.dart';
import '../constants.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 160;
  int weight = 70;
  int age = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.pink,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.question_answer, color: Colors.white),
        ),
      ),
      appBar: AppBar(title: Text('CALCULADORA IMC'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: Box(
                    bgColor:
                        selectedGender == Gender.male
                            ? kActiveColor
                            : kInactiveColor,
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                      if (kDebugMode) {
                        print('female card was pressed');
                      }
                    },
                    child: IconContent(icon: Icons.male, label: 'HOMEM'),
                  ),
                ),
                Expanded(
                  child: Box(
                    bgColor:
                        selectedGender == Gender.female
                            ? kActiveColor
                            : kInactiveColor,
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                      if (kDebugMode) {
                        print('female card was pressed');
                      }
                    },
                    child: IconContent(icon: Icons.female, label: 'MULHER'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Box(
              bgColor: kInactiveColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('ALTURA', style: kLabelStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString(), style: kBoldStyle),
                      Text('cm', style: kLabelStyle),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xffeb1555),
                      overlayColor: Color(0x40eb1555),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                      // overlayShape: RoundSliderThumbShape(
                      //   enabledThumbRadius: 30,
                      //   disabledThumbRadius: 30,
                      // ),
                    ),
                    child: Slider(
                      // activeColor: Color(0xffeb1555),
                      // inactiveColor: Color(0xff8d8e98),
                      value: height.toDouble(),
                      min: 100,
                      max: 230,
                      onChanged: (double value) {
                        setState(() {
                          height = value.round();
                        });
                        if (kDebugMode) {
                          print(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: Box(
                    bgColor: kActiveColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('PESO', style: kLabelStyle),
                        Text(weight.toString(), style: kBoldStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleButton(
                              icon: Icons.remove,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            CircleButton(
                              icon: Icons.add,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Box(
                    bgColor: kActiveColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('IDADE', style: kLabelStyle),
                        Text(age.toString(), style: kBoldStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleButton(
                              icon: Icons.remove,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            CircleButton(
                              icon: Icons.add,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CalcButton(
              text: 'CALCULAR',
              onTap: () {
                var calc = CalcModel(height: height, weight: weight);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ResultPage(
                          bmiResult: calc.calculateBMI(),
                          resultText: calc.result,
                          interpretation: calc.interpretation,
                        ),
                  ),
                );

                //Navigator.pushNamed(context, '/result');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;

  const CircleButton({super.key, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6,
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      onPressed: onPressed,
      shape: CircleBorder(),
      fillColor: Color(0xff4c4f5e),
      child: Icon(icon, color: Colors.white),
    );
  }
}
