import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToInt', () {
    test(
      'should return an integer when string passed is number',
      () async {
        //arrange
        const str = '122';
        //act
        final result = inputConverter.stringToInt(str);
        //assert
        expect(result, const Right(122));
      },
    );
    test(
      'should return a failure when string is not integer',
      () async {
        //arrange
        const str = 'aaa';
        //act
        final result = inputConverter.stringToInt(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a failure when string is negative integer',
      () async {
        //arrange
        const str = '-122';
        //act
        final result = inputConverter.stringToInt(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
