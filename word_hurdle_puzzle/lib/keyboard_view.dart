import 'package:flutter/material.dart';

const keyList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ç'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
];

class KeyboardView extends StatelessWidget {
  final List<String> excludedLetters;
  final Function(String) onPress;

  const KeyboardView({
    super.key,
    required this.excludedLetters,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          spacing: 4,
          children: [
            for (var i = 0; i < keyList.length; i++)
              Row(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    keyList[i]
                        .map(
                          (e) => Key(
                            letter: e,
                            excluded: excludedLetters.contains(e),
                            onPress: (value) {
                              onPress(value);
                            },
                          ),
                        )
                        .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class Key extends StatelessWidget {
  final String letter;
  final bool excluded;
  final Function(String) onPress;

  const Key({
    super.key,
    required this.letter,
    required this.excluded,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: excluded ? Colors.red : Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          onPress(letter);
        },
        child: Text(letter, style: TextStyle(fontFamily: 'cutive')),
      ),
    );
  }
}
