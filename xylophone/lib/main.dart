import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Xylophone());
}

class Xylophone extends StatelessWidget {
  Xylophone({super.key});

  playNote(int note) async {
    print(note);
    final player = AudioPlayer();
    await player.setSource(AssetSource('note$note.wav'));
    player.resume();
    print(note);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  playNote(1);
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.red,
                  child: Text('play'),
                ),
              ),
              TextButton(
                onPressed: () {
                  print('play note2');
                  playNote(2);
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.orange,
                  child: Text('play'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
