import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:wryter/constants.dart';

class PromtGenerator {
  // List<String> words = [];

  int wordCount = 0;
  int maxWordCount = 50;
  int lettersInThisRow = 0;
  var shuffledNouns = nouns.toList()..shuffle();

  // var buffer = StringBuffer();

  List<TextSpan> spans = [];

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

      if (lettersInThisRow + shuffledNouns[wordCount + 1].length > 40) {
        spans.add(
          const TextSpan(
            text: '\n',
          ),
        );
        lettersInThisRow = 0;
      } else {
        spans.add(
          const TextSpan(
            text: '_',
            style: TextStyle(color: Colors.transparent),
          ),
        );
      }

      wordCount++;
    }

    return spans;
  }
}
