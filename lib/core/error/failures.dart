import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class FailureImpl extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends FailureImpl {}

class CacheFailure extends FailureImpl {}
