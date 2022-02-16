import 'package:flutter/material.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Colors.blueGrey,
            height: MediaQuery.of(context).size.height / 4.0,
            child: Column(
              children: const [
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  'Number Trivia App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
