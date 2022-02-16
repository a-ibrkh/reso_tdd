import 'dart:convert';

import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel =
      NumberTriviaModel(number: 4, text: 'Text for testing');
  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group(
    'from Json',
    () {
      test(
        'should return a valid modelwhen number in json is integer',
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);
          expect(result, tNumberTriviaModel);
        },
      );
      test(
        'should return a valid modelwhen number in json is regarded as double',
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia_double.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);
          expect(result, tNumberTriviaModel);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a json map containing proper data',
        () async {
          final result = tNumberTriviaModel.toJson();
          final expectedMap = {
            "text": "Text for testing",
            "number": 4,
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
