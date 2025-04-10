import 'dart:math';

import 'package:english_words/english_words.dart' as words;
import 'package:flutter/foundation.dart';

import 'wordle.dart';

class AppState extends ChangeNotifier {
  final random = Random.secure();

  List<String> allWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';
  int index = 0;
  int count = 0;
  bool wins = false;
  int attempts = 0;

  bool get showCheckForAnswer => rowInputs.length == 5;

  bool get isAValidWord => allWords.contains(rowInputs.join('').toLowerCase());

  bool get isNoAttempsLeft => attempts == 6;

  void reset() {
    index = 0;
    count = 0;
    wins = false;
    attempts = 0;
    targetWord = '';
    rowInputs.clear();
    hurdleBoard.clear();
    excludedLetters.clear();
    generateBoard();
    getRandomWord();
    notifyListeners();
  }

  void init() {
    allWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    getRandomWord();
  }

  void generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  void getRandomWord() {
    targetWord = allWords[random.nextInt(allWords.length)].toUpperCase();
    if (kDebugMode) {
      print(targetWord);
    }
  }

  void inputLetter(String letter) {
    if (count < 5) {
      rowInputs.add(letter);
      count++;
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
      notifyListeners();
    }
    if (kDebugMode) {
      print(rowInputs);
    }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeLast();
    }
    if (count > 0) {
      hurdleBoard[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }
    notifyListeners();
  }

  void checkAnswer() {
    final input = rowInputs.join('');
    if (targetWord == input) {
      wins = true;
    } else {
      _markLetterOnBoard();
      if (attempts < 6) {
        _goToNextRow();
      }
    }
  }

  void _goToNextRow() {
    attempts++;
    count = 0;
    rowInputs.clear();
  }

  void _markLetterOnBoard() {
    for (int i = 0; i < hurdleBoard.length; i++) {
      if (hurdleBoard[i].letter.isNotEmpty &&
          targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].existsInTarget = true;
      } else if (hurdleBoard[i].letter.isNotEmpty &&
          !targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].doesNotExistInTarget = true;
        excludedLetters.add(hurdleBoard[i].letter);
      }
    }
    notifyListeners();
  }
}
