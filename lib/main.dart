import 'promt_generator.dart';
import 'constants.dart';

import 'package:flutter/material.dart';

String promtString = '';
String inputString = '';
List<TextSpan> spans = [];
bool isCorrect = true;
int counter = 0;
int prevLength = 0;

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

  @override
  void initState() {
    promtString = promtGenerator.generatePromt();

    _textController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
//remove chars from richtext if backspace is used in textfield to keep it same
    while (_textController.text.length < inputString.length) {
      inputString = inputString.substring(0, inputString.length - 2);
    }

//check if textfield change is due to new char and not due to backspace
    if (_textController.text.length > inputString.length) {
      inputString += _textController.text[_textController.text.length - 1];
      counter = _textController.text.length;

      if (inputString != '') {
// check if input is correct

        isCorrect =
            (promtString[counter - 1] == _textController.text[counter - 1])
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
            _textController.value = TextEditingValue(
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
                  Text(
                    'Wryter_',
                    style: TextStyle(
                      fontSize: 100,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      color: Constants.promtTextColor,
                    ),
                  ),
//Stack
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 150,
                      width: 1000,
                      child: Stack(
                        children: [
//prompt
                          RichText(
                            maxLines: 3,
                            softWrap: true,
                            text: TextSpan(
                              text: promtString,
                              style: TextStyle(
                                color: Constants.promtTextColor,
                                fontSize: 45,
                              ),
                            ),
                          ),

//input textfield
                          TextField(
                            maxLines: 3,
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
// shaded cover text
                          ShaderMask(
                            shaderCallback: (bounds) => Constants
                                .myLinearGradientDark
                                .createShader(Rect.fromPoints(
                                    const Offset(0, 0),
                                    // Offset(MediaQuery.of(context).size.width,
                                    //     MediaQuery.of(context).size.height))),
                                    const Offset(750 / 2.5, 1480 / 3))),
                            child: Text(
                              _textController.text,
                              style: const TextStyle(
                                  fontSize: 45, color: Colors.white),
                            ),
                          ),
// spans for wrong input
                          RichText(
                            maxLines: 3,
                            softWrap: true,
                            key: UniqueKey(),
                            text: TextSpan(
                              children: spans,
                              style: const TextStyle(fontSize: 45),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 150,
                  ),
                  // ShaderMask(
                  //   shaderCallback: (bounds) =>
                  //       Constants.myLinearGradient.createShader(bounds),
                  //   child: Text(
                  //     'Test Text zum testen',
                  //     style: TextStyle(
                  //         fontSize: 45, color: Colors.cyan.withOpacity(0.3)),
                  //   ),
                  // )
                  // Text(
                  //     'Input string:    $inputString \ninput counter: $counter \niscorrect = $isCorrect \nmyCharP: ${promtString[counter]}\nspans length: ${spans.length}'),
                  // Text((inputString == '') ? 'empty' : inputString[counter]),
                  // Text(
                  //   'TextController:    ${_textController.text} \n TextControllerLength:    ${_textController.text.length}',
                  // ),
                  // Text((inputString == '') ? 'empty' : inputString[counter]),
                ],
              ),
            ),
            // Container(color: Colors.red, height: 750, width: 1480)
          ],
        ),
      ),
    );
  }
}
