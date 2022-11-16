import 'package:english_words/english_words.dart';

class PromtGenerator {
  // List<String> words = [];

  int wordCount = 0;
  int maxWordCount = 25;

  var buffer = StringBuffer();

  String generatePromt() {
    // words ;
    for (var i = 0; i < maxWordCount; i++) {
      buffer.write(nouns[i]);
      buffer.write('_');
      wordCount++;
    }
    return buffer.toString();
  }
}
