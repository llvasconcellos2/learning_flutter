import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/app_state.dart';
import 'package:word_hurdle_puzzle/keyboard_view.dart';
import 'package:word_hurdle_puzzle/wordle_view.dart';

import 'helper_functions.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<AppState>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Word Hurdle')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Consumer<AppState>(
                  builder:
                      (context, provider, child) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                        ),
                        itemCount: provider.hurdleBoard.length,
                        itemBuilder: (context, index) {
                          final wordle = provider.hurdleBoard[index];
                          return WordleView(wordle: wordle);
                        },
                      ),
                ),
              ),
            ),
            Consumer<AppState>(
              builder: (context, provider, child) {
                return KeyboardView(
                  excludedLetters: provider.excludedLetters,
                  onPress: (value) {
                    provider.inputLetter(value);
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Consumer<AppState>(
                builder: (context, state, widget) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          state.deleteLetter();
                        },
                        child: Text('DELETE'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!state.isAValidWord) {
                            showMsg(
                              context,
                              'Não é uma palavra no meu dicionário.',
                            );
                          }
                          if (state.showCheckForAnswer) {
                            state.checkAnswer();
                          }
                          if (state.wins) {
                            showResult(
                              context: context,
                              title: 'Você Ganhou!',
                              body: 'A palavra era ${state.targetWord}',
                              onPlayAgain: () {
                                state.reset();
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            );
                          } else if (state.isNoAttempsLeft) {
                            showResult(
                              context: context,
                              title: 'Você Perdeu!',
                              body: 'A palavra era ${state.targetWord}',
                              onPlayAgain: () {
                                state.reset();
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                        child: Text('ENVIAR'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
