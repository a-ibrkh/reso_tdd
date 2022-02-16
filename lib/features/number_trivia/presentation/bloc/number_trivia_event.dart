part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberText;

  const GetTriviaForConcreteNumber(this.numberText);

  @override
  List<Object> get props => [numberText];

}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
