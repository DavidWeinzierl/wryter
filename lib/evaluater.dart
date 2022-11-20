import 'package:flutter/material.dart';
import 'package:wryter/constants.dart';

class Evaluator {
  List<TextSpan> wrongWordsSpan = [];
  List<TextSpan> currentWord = [];

  bool isCorrect = true;
  int offset = 0;

  List<TextSpan> evaluate(List<TextSpan> spans, int currentPosition) {
    wrongWordsSpan.clear();
    print(currentPosition);

// for the first line there wont be an element with \n => ternary operator checks is it is first line (pos <70)

    offset = currentPosition < 70
        ? 0
        : spans.indexWhere((e) => e.text == '\n', currentPosition - 50);

    for (var i = offset; i <= currentPosition; i++) {
      currentWord.add(spans[i]);
      if (spans[i].text == '_' || spans[i].text == '\n') {
        // removeLast so that wrong '_' doesn't count for the current word and also to not add `\n`
        currentWord.removeLast();
        if (currentWord
            .any((element) => element.style?.color == Constants.wrongColor)) {
          // if the list is not empty add a '_' before the new word

          // add current word to wrongwords but change color to promtcolor
          for (var span in currentWord) {
            wrongWordsSpan.add(TextSpan(
              text: span.text,
              style: TextStyle(color: Constants.promtTextColor),
            ));
          }
          if (wrongWordsSpan.isNotEmpty) {
            wrongWordsSpan.add(
              const TextSpan(
                text: '_',
                style: TextStyle(color: Colors.transparent),
              ),
            );
          }
        }
        currentWord.clear();
      }
    }

    return wrongWordsSpan;
  }
}
