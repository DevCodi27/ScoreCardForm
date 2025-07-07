import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:forms/screen/cards/score_card.dart';

class ScoreForm extends StatefulWidget {
  const ScoreForm({super.key});

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Forms"), centerTitle: true),

        body: AnimatedBackground(
          behaviour: BubblesBehaviour(),
          vsync: this,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScoreCardForm()),
                    );
                  },
                  child: Text(
                    "Score Card",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
