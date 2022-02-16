import 'package:flutter/material.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({Key? key, required this.trivia}) : super(key: key);
  final NumberTrivia trivia;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            trivia.number.toString(),
            style: const TextStyle(
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Text(
                  trivia.text,
                  style: const TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
