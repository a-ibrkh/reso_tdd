
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/data_sources/number_trivia_remote_datasources.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDatasourceImpl remoteDatasource;
  late MockHttpClient mockHttpClient;

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 404));
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDatasource = NumberTriviaRemoteDatasourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri.parse('http://numbersapi.com/3'));
  });
  group('getConcreteNumberTrivia', () {
    const tNumber = 4;
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Text for testing', number: 4);
    Uri url = Uri.parse('http://numbersapi.com/$tNumber');
    test(
      'should perform a GET request on a url with number being endpoint and with application/json header',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        remoteDatasource.getConcreteNumberTrivia(tNumber);
        //assert
        verify(() => mockHttpClient
            .get(url, headers: {'Content-type': 'application/json'}));
      },
    );

    test(
      'should return NumberTriviaModel when responce code is 200',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        final result = await remoteDatasource.getConcreteNumberTrivia(tNumber);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should throw a server exceotion when response is wrong',
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = remoteDatasource.getConcreteNumberTrivia;
        //assert
        expect(
            () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Text for testing', number: 4);
    Uri url = Uri.parse('http://numbersapi.com/random');
    test(
      'should perform a GET request on a url with number being endpoint and with application/json header',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        remoteDatasource.getRandomNumberTrivia();
        //assert
        verify(() => mockHttpClient
            .get(url, headers: {'Content-type': 'application/json'}));
      },
    );

    test(
      'should return NumberTriviaModel when responce code is 200',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        final result = await remoteDatasource.getRandomNumberTrivia();
        //assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should throw a server exceotion when response is wrong',
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = remoteDatasource.getRandomNumberTrivia;
        //assert
        expect(
            () => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
