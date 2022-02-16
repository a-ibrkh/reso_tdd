import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class InputControl extends StatefulWidget {
  const InputControl({
    Key? key,
  }) : super(key: key);

  @override
  State<InputControl> createState() => _InputControlState();
}

class _InputControlState extends State<InputControl> {
 late String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
              ),
            ),
            onChanged: (value) {
              inputStr = value;
            }),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NumberTriviaBloc>(context)
                      .add(GetTriviaForConcreteNumber(inputStr));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade800,
                ),
                child: const Text('Search'),
              ),
            ),
            const SizedBox(
              width: 18.0,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NumberTriviaBloc>(context)
                      .add(GetTriviaForRandomNumber());
                },
                child: const Text('Random search'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
