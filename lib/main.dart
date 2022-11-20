import 'promt_generator.dart';
import 'constants.dart';
import 'evaluater.dart';

import 'package:flutter/material.dart';

List<TextSpan> spans = [];
List<TextSpan> wrongWords = [];
bool isCorrect = true;
int counter = 0;
double top = 0.0;

PromtGenerator promtGenerator = PromtGenerator();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _textController;
  late Evaluator _evaluator;

  @override
  void initState() {
    _evaluator = Evaluator();
    for (var i = 0; i < 3; i++) {
      spans.addAll(PromtGenerator().generateNewPromtLine(wrongWords));
    }

    _textController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
// make sure only one key input is accepted if two keys are pressed at the same time
    while (_textController.text.length > counter + 1) {
      _textController.value = TextEditingValue(
        text:
            _textController.text.substring(0, _textController.text.length - 1),
        selection: TextSelection.collapsed(offset: _textController.text.length),
      );
    }

// take care of backspace
    while (_textController.text.length < counter) {
      spans[counter - 1] = TextSpan(
          text: spans[counter - 1].text,
          style: TextStyle(
              color: (spans[counter - 1].text == '_')
                  ? Colors.transparent
                  : Constants.promtTextColor));

      counter = _textController.text.length;
//animation back up
      if (spans[counter].text == '\n' && counter > 50) {
        top += Constants.animationOffset;
      }
    }

// check if text change is due to key input and not due to TC.text change or backspace
    if (_textController.text.length > counter) {
      //animation down
      if (spans[counter].text == '\n') {
        //todo include wrong words in new promt
        //todo evaluate() which words are wrong

        // add all after last \n
        wrongWords = _evaluator.evaluate(spans, counter);
        // wrongWords.addAll(_evaluator.evaluate(spans, counter));
        // wrongWords = Evaluator().evaluate(spans);
        spans.addAll(PromtGenerator().generateNewPromtLine(wrongWords));

        if (counter > 50) {
          top -= Constants.animationOffset;
        }
      }

      counter = _textController.text.length;

// 	check isCorrect
      isCorrect =
          (spans[counter - 1].text == _textController.text[counter - 1] ||
                  ((spans[counter - 1].text == '_' ||
                          spans[counter - 1].text == '\n') &&
                      _textController.text[counter - 1] == ' '))
              ? true
              : false;

// 	true: span green
      if (isCorrect) {
        if (!(spans[counter - 1].text == '_')) {
          spans[counter - 1] = TextSpan(
              text: spans[counter - 1].text,
              style:
                  TextStyle(color: Constants.promtTextColor.withOpacity(0.2)));
        }
      }
// 	false spans: red
      else {
        spans[counter - 1] = TextSpan(
            text: spans[counter - 1].text,
            style: TextStyle(color: Constants.wrongColor));
      }

//replace last char of TC.text with promt
      _textController.value = TextEditingValue(
        text:
            _textController.text.substring(0, _textController.text.length - 1) +
                spans[counter - 1].text!,
        selection: TextSelection.collapsed(offset: _textController.text.length),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
//background
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: Constants.myLinearGradient,
              ),
            ),
//title
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      'Wryter_',
                      style: TextStyle(
                        fontSize: 100,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                        color: Constants.promtTextColor,
                      ),
                    ),
                  ),
//Stack
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: SizedBox(
                      height: 270,
                      width: 1100,
                      child: Stack(
                        children: [
//prompt
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                            top: top,
                            child: RichText(
                              // maxLines: 5,
                              softWrap: true,
                              key: UniqueKey(),
                              // textAlign: TextAlign.center,
                              text: TextSpan(
                                children: spans,
                                style: const TextStyle(fontSize: 45),
                              ),
                            ),
                          ),

//input textfield
                          TextFormField(
                            // 2 lines so the cursor will stay on line 2
                            maxLines: 2,
                            cursorColor: Constants.cursorColor,
                            cursorWidth: 4,
                            cursorRadius: const Radius.circular(2),
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                            autofocus: true,
                            controller: _textController,
                            style: const TextStyle(
                              fontSize: 45,
                              color: Colors.transparent,
                            ),
                          ),
//
                        ],
                      ),
                    ),
                  ),

                  Text(isCorrect.toString()),
                  Text('counter: $counter'),
                  Text('spanslength: ${spans.length}'),
                  Text('_textController: ${_textController.text.length}'),
                  const Text('wrongWords:'),
                  RichText(
                    // maxLines: 5,
                    softWrap: true,
                    key: UniqueKey(),
                    // textAlign: TextAlign.center,
                    text: TextSpan(
                      children: wrongWords,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  // Text(_textController.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
