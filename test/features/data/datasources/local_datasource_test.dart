import 'dart:convert';

import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/data_sources/local_datasource.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDatasourceImpl localDatasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDatasource = NumberTriviaLocalDatasourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group(
    'getLastNumberTrivia',
    () {
      final tNumberTriviaModel = NumberTriviaModel.fromJson(
          json.decode(fixture('trivia_cached.json')));
      test(
        'should return NumberTriviaModel from SharedPreferences when it exists in cache',
        () async {
          when(() => mockSharedPreferences.getString(any()))
              .thenReturn(fixture('trivia_cached.json'));
          final result = await localDatasource.getLastNumberTrivia();

          verify(() => mockSharedPreferences.getString('cache'));

          expect(result, tNumberTriviaModel);
        },
      );

      test(
        'should throw cache exception when there is no data present',
        () async {
          when(() => mockSharedPreferences.getString(any())).thenReturn(null);
          final call = localDatasource.getLastNumberTrivia;

          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group(
    'cache NUmber trivia',
    () {
      const tNumberTriviaModel = NumberTriviaModel(text: 'text', number: 4);
      test(
        'should call shared preferences to cache data',
        () async {
          final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
          //arrange
          when(() =>
                  mockSharedPreferences.setString('cache', expectedJsonString))
              .thenAnswer((_) async => true);
          //act
          localDatasource.cacheNumberTrivia(tNumberTriviaModel);
          //assert

          verify(() =>
              mockSharedPreferences.setString('cache', expectedJsonString));
        },
      );
    },
  );
}
