import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/widgets/drawer.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/widgets/trivia_display.dart';

import '../../../../injection_container.dart';
import '../widgets/input_control.dart';
import '../widgets/message_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Meaning of numbers',
          style: TextStyle(fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: BlocProvider(
        create: (context) => sl<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                //Top half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(message: 'Start Searching!');
                    } else if (state is Loading) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height/3,
                          child: const CircularProgressIndicator.adaptive());
                    } else if (state is Loaded) {
                      return TriviaDisplay(trivia: state.trivia);
                    } else if (state is Error) {
                      return MessageDisplay(message: state.errorMessage);
                    } else {
                      return const MessageDisplay(message: 'Number Trivia');
                    }
                  },
                ),
                //bottom half
                const SizedBox(
                  height: 20.0,
                ),
               const InputControl(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

