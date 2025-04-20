import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormatedDateTime(num dt, [String pattern = 'yyyy-MM-dd']) =>
    DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()));

String translate(String input) {
  return input
      .replaceAll(' of ', ' de ')
      .replaceAll(' W ', ' Oeste ')
      .replaceAll(' S ', ' Sul ')
      .replaceAll(' E ', ' Leste ')
      .replaceAll(' SW ', ' Sudoeste ')
      .replaceAll('Mid-Atlantic Ridge', 'Dorsal Mesoatlântica')
      .replaceAll(' southern ', ' ao sul ')
      .replaceAll(' north ', ' Norte ')
      .replaceAll(' NW ', ' Noroeste ')
      .replaceAll(' WNW ', ' Oeste-Noroeste ')
      .replaceAll(' NE ', ' Nordeste ')
      .replaceAll(' NNE ', ' Nor-Nordeste ')
      .replaceAll(' SE ', ' Sudeste ')
      .replaceAll(' SSW ', ' Sul-Sudoeste ')
      .replaceAll(' SSE ', ' Sul-Sudeste ')
      .replaceAll(' SW ', ' Sudoeste ');
}

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
