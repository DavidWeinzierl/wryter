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
    spans = promtGenerator.generatePromtSpans();

    _textController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // counter = _textController.text.length;

    if (_textController.text.length > inputString.length) {
      inputString += _textController.text[_textController.text.length - 1];
      counter = _textController.text.length;

      if (inputString != '') {
        isCorrect = (_textController.text[counter - 1] == spans[counter - 1])
            ? true
            : false;

        if (isCorrect) {
          String? s = spans[counter].text;
          spans.add(
            TextSpan(
              text: spans[counter].text,
              style: const TextStyle(color: Colors.green),
            ),
          );
          spans.removeAt(counter + 5);
        }
      } else {
// remove spans if backspace was pressed
        // while (spans.length > inputString.length) {
        // spans.removeAt(spans.length - 1);
        // }
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
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: spans,
                              style: const TextStyle(fontSize: 45),
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
                          // ShaderMask(
                          //   shaderCallback: (bounds) => Constants
                          //       .myLinearGradientDark
                          //       .createShader(Rect.fromPoints(
                          //           const Offset(0, 0),
                          //           // Offset(MediaQuery.of(context).size.width,
                          //           //     MediaQuery.of(context).size.height))),
                          //           const Offset(750 / 2.5, 1480 / 3))),
                          //   child: Text(
                          //     _textController.text,
                          //     style: const TextStyle(
                          //         fontSize: 45, color: Colors.white),
                          //   ),
                          // ),
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
                  Text(isCorrect.toString()),
                  Text(inputString),
                  Text(_textController.text.length.toString()),
                  Text(_textController.text),
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
