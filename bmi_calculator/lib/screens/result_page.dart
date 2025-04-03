import 'package:bmi_calculator/components/calc_button.dart';
import 'package:flutter/material.dart';

import '../components/box.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  const ResultPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CALCULADORA IMC'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                'RESULTADO',
                style: kBoldStyle.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Expanded(
            flex: 13,
            child: Box(
              bgColor: kInactiveColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(resultText, style: kResultStyle),
                  Text(bmiResult, style: kBoldStyle.copyWith(fontSize: 100)),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: kResultStyle,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CalcButton(
              text: 'RE-CALCULAR',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
