import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:wryter/constants.dart';

class PromtGenerator {
  // List<String> words = [];

  int wordCount = 0;
  int maxWordCount = 25;
  int lettersInThisRow = 0;
  var shuffledNouns = nouns.toList()..shuffle();

  // var buffer = StringBuffer();

  List<TextSpan> spans = [];

  // String generatePromt() {
  //   // words ;
  //   for (var i = 0; i < maxWordCount; i++) {
  //     buffer.write(nouns[i]);
  //     buffer.write('_');
  //     wordCount++;
  //   }
  //   return buffer.toString();
  // }

  // void changeColor(int i) {
  //   spans[i].style?.color = Colors.green;
  // }

  List<TextSpan> generatePromtSpans() {
    for (var i = 0; i < maxWordCount; i++) {
      for (var j = 0; j < shuffledNouns[wordCount].length; j++) {
        spans.add(
          TextSpan(
            text: shuffledNouns[wordCount][j],
            style: TextStyle(color: Constants.promtTextColor),
          ),
        );
        lettersInThisRow++;
      }

      spans.add(
        const TextSpan(
          text: '_',
          style: TextStyle(color: Colors.transparent),
        ),
      );
      if (lettersInThisRow > 30) {
        spans.add(
          const TextSpan(
            text: '\n',
          ),
        );
        lettersInThisRow = 0;
      }

      wordCount++;
    }

    return spans;
  }
}
