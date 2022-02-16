import 'package:flutter/material.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/pages/settings_page.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter_tdd/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Number Trivia App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
            .copyWith(secondary: Colors.blueGrey.shade800),
      ),
      routes: {
        NumberTriviaPage.routeName: ((context) => const NumberTriviaPage()),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
      home: const NumberTriviaPage(),
    );
  }
}
