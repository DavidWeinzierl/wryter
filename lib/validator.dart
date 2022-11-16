import 'constants.dart';

import 'package:flutter/material.dart';

class Validator {
  String promtString = '';
  String inputString = '';
// String dummy = '';
// String realString = '';
  List<TextSpan> spans = [];
  bool isCorrect = true;
  int counter = 0;
  int prevLength = 0;

  void validate(TextEditingController textController) {
//remove chars from richtext if backspace is used in textfield to keep it same
    while (textController.text.length < inputString.length) {
      inputString = inputString.substring(0, inputString.length - 2);
    }

//check if textfield change is due to new char and not due to backspace
    if (textController.text.length > inputString.length) {
      inputString += textController.text[textController.text.length - 1];
      counter = textController.text.length;

      if (inputString != '') {
// check if input is correct

        isCorrect =
            (promtString[counter - 1] == textController.text[counter - 1])
                ? true
                : false;

//add char to text
        if (inputString.length > spans.length) {
          if (isCorrect) {
            spans.add(TextSpan(
                text: inputString[inputString.length - 1],
                style: const TextStyle(
                  color: Colors.transparent,
                )));
          } else if (!isCorrect && promtString[inputString.length - 1] == ' ') {
            spans.add(TextSpan(
                text: '_',
                style: TextStyle(
                  color: Constants.wrongColor,
                )));
          } else {
            spans.add(TextSpan(
                text: promtString[inputString.length - 1],
                style: TextStyle(
                  color: Constants.wrongColor,
                )));

//TODO: Check for whitespace and enter underscore if wrong

//change textfield to correct text to keep curser in correct position and set cursor to end of line
            textController.value = TextEditingValue(
              text: promtString.substring(0, inputString.length),
              selection: TextSelection.collapsed(offset: inputString.length),
            );
          }
        } else {
// remove spans if backspace was pressed
          while (spans.length > inputString.length) {
            spans.removeAt(spans.length - 1);
          }
        }
      }
    }
  }
}
