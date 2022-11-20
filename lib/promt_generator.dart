import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:wryter/constants.dart';

class PromtGenerator {
  int maxLetters = 45;
  int minLetters = 42;

  List<TextSpan> spans = [];

  List<TextSpan> generateNewPromtLine(List<TextSpan> wrongWords) {
    spans.clear();
    spans.addAll(wrongWords);

    while (spans.length < minLetters) {
      var randomNoun = (nouns.toList()..shuffle()).first;

      if (randomNoun.length < maxLetters - spans.length) {
        for (var i = 0; i < randomNoun.length; i++) {
          spans.add(
            TextSpan(
              text: randomNoun[i],
              style: TextStyle(color: Constants.promtTextColor),
            ),
          );
        }
        spans.add(
          const TextSpan(
            text: '_',
            style: TextStyle(color: Colors.transparent),
          ),
        );
      }
    }
    // replace the last ' ' with \n
    spans[spans.length - 1] = const TextSpan(
      text: '\n',
    );

    return spans;
  }
}
