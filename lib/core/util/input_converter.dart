import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/core/error/failures.dart';

class InputConverter extends Equatable{
  Either<FailureImpl, int> stringToInt(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) {
        throw FormatException();
      } else {
        return Right(integer);
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InvalidInputFailure extends FailureImpl {}
